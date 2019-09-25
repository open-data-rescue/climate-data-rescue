##
# Use this behind the scenes to migrate files from your filesystem to Amazon S3
# %: rake paperclip_migration:migrate_to_s3
##

namespace :attachments do
  desc "migrate files from filesystem to s3"
  task :migrate_to_s3 => :environment do
    require 'aws-sdk-s3'

    bucket =  ENV.fetch('S3_PRIVATE_BUCKET')

    # Establish S3 connection
    Aws.config.update({
      region: ENV.fetch('S3_REGION'),
      credentials: Aws::Credentials.new(
        ENV.fetch('S3_ACCESS_KEY_ID'),
        ENV.fetch('S3_SECRET_ACCESS_KEY')
      ),
      endpoint: "#{ENV.fetch('S3_PROTOCOL')}://#{ENV.fetch('S3_HOST_NAME')}",
      force_path_style: true
    })
    s3_bucket = Aws::S3::Bucket.new(bucket)

    # determine the models to migrate
    klasses = %i[content_image field_option page user]

    klasses.each do |klass_sym|
      if @klass = real_klass(klass_sym)
        if @klass.respond_to?(:attachment_definitions) && definitions = @klass.attachment_definitions

          total_items  = @klass.count
          current_item = 1

          @klass.all.each do |record|
            definitions.each_pair do |column, value|
              attachment = record.send(column.to_sym)

              # NOTE: If the application is configured to use S3 already,
              # calling exists? won't work as expected because paperclip will automatically look on Amazon.
              if !attachment.exists?
                total_items -= 1
                next
              end

              styles = value[:styles].keys
              styles.push(:original)

              styles.each do |style|
                # whatever mapping needed to where your files will live on S3
                # in my case, I changed the URL when migrating to S3
                path = attachment.url(style.to_sym).gsub('/system/', '').partition('?').first.gsub('images', 'pages')
                begin

                  file = File.open("#{Rails.root}/public#{attachment.url(style.to_sym).partition('?').first}")
                  # file = Paperclip.io_adapters.for(attachment)

                  # skip if we already have this file on S3
                  # byebug
                  object = s3_bucket.object(path)
                  # next if object.exists?

                  print "uploading: #{style.to_sym}..."
                  object.upload_file(file, { acl: :public_read})
                  print " done.\n"
                rescue Errno::ENOENT => e
                  puts "File #{full_path} not found"
                # rescue Aws::S3::NoSuchBucket => Errno
                #   Aws::S3::Bucket.create(bucket)
                #   retry
                # rescue Aws::S3::ResponseError => e
                #   raise

                rescue => e
                  puts e.message
                end
              end

              # fancy output
              percent_complete = ((current_item.to_f / total_items.to_f) * 100).round(2)

              puts "Completed: #{current_item} / #{total_items}: ~#{percent_complete}%"

              current_item += 1
            end
          end

        else
          puts "There are no paperclip attachments defined for: #{@klass.to_s}"
        end
      else
        puts "#{klass_sym.to_s.classify} is not an existing model."
      end
    end
  end

  def real_klass(key)
    key.to_s.classify.constantize
  rescue
  end
end