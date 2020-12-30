
<template>
  <b-container
    class="accounts-receivable-table-wrapper mb-3"
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
          class="accounts-receivable-table"
          selectable
          responsive
          foot-clone
          no-local-sorting
          no-footer-sorting
          no-sort-reset
          striped
          hover
          primary-key="id"
          empty-text="None"
          empty-filter-text="None matching filters"
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
            v-slot:cell(selected)="data"
          >
            <span v-if="data.rowSelected">✔</span>
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
            v-slot:cell(title)="data"
          >
            {{ data.item.attributes.title }}
          </template>
          <template
            v-slot:cell(start_date)="data"
          >
            {{ data.item.attributes.start_date }}
          </template>
          <template
            v-slot:cell(end_date)="data"
          >
            {{ data.item.attributes.end_date }}
          </template>
          <template
            v-slot:cell(visible)="data"
          >
            <span v-if="data.item.attributes.visible">✔</span>
          </template>
          <template
            v-slot:cell(complete)="data"
          >
            <span v-if="data.item.attributes.complete">✔</span>
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
import TableTextFilter from './TableTextFilter'

export default {
  name: 'PagesTable',
  components: {
    TableTextFilter
  },
  data () {
    return {
      fields: [
        {
          key: 'selected',
          label: 'Select All',
          class: 'selected'
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
          sortable: true
        },
        {
          key: 'complete',
          label: 'Complete',
          class: 'complete',
          sortable: true
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
      selected: [],
      filters: {
        id: ''
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
        'filters[title]': this.filters.title,
        'filters[start_date]': this.filters.start_date,
        'filters[end_date]': this.filters.end_date,
      }).then(response => {
        // set the total rows from the response meta
        if (response.meta && response.meta.total) {
          this.totalRows = response.meta.total
        }

        if (response.data) {
          // Pluck the array of pages off our axios response
          this.pages = response.data.map(page => {
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

</style>