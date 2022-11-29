
export const transcription_columns = [
  {
    key: 'id',
    label: 'ID',
    sortable: true
  },
  {
    key: 'page_image',
    label: '',
    sortable: false
  },
  {
    key: 'page.title',
    label: 'Page Title',
    sortable: true
  },
  {
    key: 'data_entries_count',
    label: 'Fields Transcribed',
  },
  {
    key: 'expected_rows_count',
    label: 'Fields Total',
  },
  {
    key: 'percent_complete',
    label: 'Percent Complete',
  },
  {
    key: 'started_rows_count',
    label: 'Rows Started',
  },
  {
    key: 'expected_rows_count',
    label: 'Rows Started',
  },
  {
    key: 'complete',
    label: 'Marked Finished?',
    sortable: true
  },
  {
    key: 'created_at',
    label: 'Started At',
    sortable: true
  },
  {
    key: 'updated_at',
    label: 'Last Updated',
    sortable: true
  },
  {
    key: 'user',
    search_key: 'user.display_name',
    label: 'User',
    sortable: false
  },
  {
    key: 'page.page_type_id',
    label: 'Page Schema',
    class: 'page-type-id',
    sortable: false
  },
  {
    key: 'actions',
    label: '',
    class: 'actions',
    sortable: false
  }
]
