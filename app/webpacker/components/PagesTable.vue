
<template>
  <b-container
    class="pages-table-wrapper mb-3"
    fluid
  >
    <b-row
      class="pagination-row"
    >
      <b-col>
        <b-input-group
          class="mb-0 pagination-group"
          prepend="Per page"
        >
          <b-form-select
            v-model="perPage"
            :options="pageOptions"
            class="page-size-selector"
            name="page_size"
          />
        </b-input-group>
      </b-col>
      <b-col>
        <b-pagination
          v-model="currentPage"
          class="my-0"
          align="right"
          :total-rows="totalRows"
          :per-page="perPage"
        />
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-table
          ref="table"
          class="pages-table"
          selectable
          responsive
          foot-clone
          no-local-sorting
          no-footer-sorting
          no-sort-reset
          striped
          hover
          sticky-header="70vh"
          primary-key="id"
          empty-text="No pages found"
          empty-filter-text="No pages match your filters"
          :show-empty="true"
          :items="getFilteredPages"
          :fields="fields"
          :current-page="currentPage"
          :per-page="perPage"
          :sort-by.sync="sortBy"
          :sort-desc.sync="sortDesc"
          :sort-direction="sortDirection"
          @row-selected="rowSelected"
        >
          <!-- TH contents -->
          <template
            v-slot:head(selected)="data"
          >
            <b>{{ data.label }}</b>

            <b-form-checkbox
              v-model="selectAll"
              @change="toggleSelectAll"
            />
          </template>
          <template
            v-slot:head(id)="data"
          >
            <b>{{ data.label }}</b>

            <table-text-filter
              v-model="filters.id"
              class="id"
            />
          </template>
          <template
            v-slot:head(title)="data"
          >
            <b>{{ data.label }}</b>

            <table-text-filter
              v-model="filters.title"
              class="title"
            />
          </template>
          <template
            v-slot:head(image_file_name)="data"
          >
            <b>{{ data.label }}</b>

            <table-text-filter
              v-model="filters.image_file_name"
              class="image_file_name"
            />
          </template>
          <template
            v-slot:head(start_date)="data"
          >
            <b>{{ data.label }}</b>

            <table-text-filter
              v-model="filters.start_date"
              class="start_date"
            />
          </template>
          <template
            v-slot:head(end_date)="data"
          >
            <b>{{ data.label }}</b>

            <table-text-filter
              v-model="filters.end_date"
              class="end_date"
            />
          </template>
          <template
            v-slot:head(visible)="data"
          >
            <b>{{ data.label }}</b>

            <table-boolean-filter
              v-model="filters.visible"
              class="visible"
            />
          </template>
          <template
            v-slot:head(done)="data"
          >
            <b>{{ data.label }}</b>

            <table-boolean-filter
              v-model="filters.done"
              class="done"
            />
          </template>

          <!-- Cells -->
          <template
            v-slot:cell(done)="data"
          >
            <span v-if="data.item.attributes.done">✔</span>
          </template>
          <template
            v-slot:cell(end_date)="data"
          >
            {{ data.item.attributes.end_date }}
          </template>
          <template
            v-slot:cell(image_file_name)="data"
          >
            {{ data.item.attributes.image_file_name }}
          </template>
          <template
            v-slot:cell(id)="data"
          >
            <b-link :href="data.item.links.admin_detail">
              {{ data.item.id }}
            </b-link>
          </template>
          <template
            v-slot:cell(page_type_id)="data"
          >
            <b-link
              v-if="data.item.page_type"
              :href="localizedPath(`/admin/page_types/${data.item.relationships.page_type.data.id}`)"
            >
              {{ data.item.page_type.attributes.title }}
            </b-link>
          </template>
          <template
            v-slot:cell(selected)="data"
          >
            <span v-if="data.rowSelected">✔</span>
          </template>
          <template
            v-slot:cell(start_date)="data"
          >
            {{ data.item.attributes.start_date }}
          </template>
          <template
            v-slot:cell(title)="data"
          >
            <b-link :href="data.item.links.admin_detail">
              {{ data.item.attributes.title }}
            </b-link>
          </template>
          <template
            v-slot:cell(visible)="data"
          >
            <span v-if="data.item.attributes.visible">✔</span>
          </template>
          <template
            v-slot:cell(created_at)="data"
          >
            {{ data.item.attributes.created_at_datestring }}
          </template>
          <template
            v-slot:cell(updated_at)="data"
          >
            {{ data.item.attributes.updated_at_datestring }}
          </template>
          <template
            v-slot:cell(actions)="data"
          >
            <b-button
              block
              variant="primary"
              :href="data.item.links.admin_edit"
            >
              Edit
            </b-button>
            <b-button
              block
              variant="danger"
              :href="data.item.links.admin_delete"
              data-method="DELETE"
              :data-confirm="`Are you sure you want to delete page #${data.item.id}: ${data.item.attributes.title}?`"
            >
              Delete
            </b-button>
          </template>
        </b-table>
      </b-col>
    </b-row>
    <b-row
      class="pagination-row"
    >
      <b-col>
        <b-input-group
          class="mb-0 pagination-group"
          prepend="Per page"
        >
          <b-form-select
            v-model="perPage"
            :options="pageOptions"
            class="page-size-selector"
            name="page_size"
          />
        </b-input-group>
      </b-col>
      <b-col>
        <b-pagination
          v-model="currentPage"
          class="my-0"
          align="right"
          :total-rows="totalRows"
          :per-page="perPage"
        />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions } from 'vuex'
import TableBooleanFilter from './TableBooleanFilter'
import TableTextFilter from './TableTextFilter'
import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'PagesTable',
  components: {
    TableBooleanFilter,
    TableTextFilter
  },
  mixins: [UrlHelpers],
  data () {
    return {
      fields: [
        // {
        //   key: 'selected',
        //   label: 'Select All',
        //   class: 'selected'
        // },
        {
          key: 'actions',
          label: '',
          class: 'actions',
          sortable: false
        },
        {
          key: 'id',
          label: 'ID',
          class: 'id number',
          sortable: true
        },
        {
          key: 'title',
          label: 'Title',
          class: 'title',
          sortable: true
        },
        {
          key: 'image_file_name',
          label: 'Filename',
          class: 'filename',
          sortable: true
        },
        {
          key: 'page_type_id',
          label: 'Page Schema',
          class: 'page-type-id',
          sortable: false
        },
        {
          key: 'page_day_ids',
          label: 'Metadata',
          class: 'page-day-ids',
          sortable: false
        },
        {
          key: 'transcription_ids',
          label: 'Transcriptions',
          class: 'transcription-ids',
          sortable: false
        },
        {
          key: 'start_date',
          label: 'Start Date',
          class: 'start-date',
          sortable: true
        },
        {
          key: 'end_date',
          label: 'End Date',
          class: 'end-date',
          sortable: true
        },
        {
          key: 'visible',
          label: 'Visible',
          class: 'visible',
          sortable: false
        },
        {
          key: 'done',
          label: 'Complete',
          class: 'done',
          sortable: false
        },
        {
          key: 'created_at',
          label: 'Created',
          class: 'created-at',
          sortable: true
        },
        {
          key: 'updated_at',
          label: 'Updated',
          class: 'updated-at',
          sortable: true
        }
      ],
      pages: [],
      page_types: [],
      selected: [],
      filters: {
        id: '',
        title: '',
        start_date: '',
        end_date: '',
        visible: null,
        done: null
      },
      totalRows: 1,
      currentPage: 1,
      perPage: 10,
      pageOptions: [10, 15, 25, 50, 100],
      selectAll: false,
      sortBy: 'created_at',
      sortDesc: true,
      sortDirection: 'asc'
    }
  },
  watch: {
    filters: {
      handler () {
        // Refresh the table when the filter values change
        this.$refs.table.refresh()
      },
      deep: true
    }
  },
  mounted () {
    // Set the initial number of pages
    this.totalRows = this.pages.length
  },
  methods: {
    ...mapActions('pages', ['getPages']),
    rowSelected (rows) {
      // Set the selected data to the rows
      this.selected = rows

      this.selectAll = this.selected.length === this.pages.length
    },
    getFilteredPages (ctx) {
      // Must return a promise that resolves to an array of items
      return this.getPages({
        'page[number]': this.currentPage,
        'page[size]': this.perPage,
        'sort[key]': ctx.sortBy,
        'sort[desc]': ctx.sortDesc,
        'filters[id]': this.filters.id,
        'filters[done]': this.filters.done,
        'filters[image_file_name]': this.filters.image_file_name,
        'filters[start_date]': this.filters.start_date,
        'filters[end_date]': this.filters.end_date,
        'filters[title]': this.filters.title,
        'filters[visible]': this.filters.visible
      }).then(response => {
        // set the total rows from the response meta
        if (response.meta && response.meta.total) {
          this.totalRows = response.meta.total
        }

        if (response.included) {
          // Store all of the page_types for the result set so they can be
          this.page_types = response.included.filter(relation => {
            return relation.type === 'page_types'
          })
        }

        if (response.data) {
          // Pluck the array of pages off our axios response
          this.pages = response.data.map(page => {
            // Find the page_type for each page, and then set the page_type
            // property on the page to the page_type we found so that the page
            // rows will have access to the page_type data
            page.page_type = this.page_types.find(pageType => {
              return pageType.id === page.relationships.page_type.data.id
            })

            return page
          })
        }

        // Must return an array of pages or an empty array if an error occurred
        return this.pages || []
      })
    },
    toggleSelectAll (checked) {
      if (checked) {
        this.$refs.table.selectAllRows()
      } else {
        this.$refs.table.clearSelected()
      }
    }
  }
}
</script>

<style scoped lang="scss">
  .pages-table {
    /deep/ th {
      vertical-align: top;

      &.selected {
        width: 105px;
        text-align: center;
      }

      &.id {
        width: 75px;

        input {
          text-align: right;
        }
      }
    }

    /deep/ td {

      &.number {
        text-align: right;
      }

      &.selected {
        text-align: center;
      }
    }
  }

  .filter {
    > .input-group-append {
      > button.btn-outline-secondary {
        border: 1px solid #ced4da;

        &:hover {
          background-color: #ced4da;
          color: #6c757d;
        }
      }
    }
  }

  .pagination-group {
    width: 230px;

    .page-size-selector {
      text-align: right;
      text-align-last: right;

      /deep/ option {
        direction: rtl;
      }
    }
  }

</style>
