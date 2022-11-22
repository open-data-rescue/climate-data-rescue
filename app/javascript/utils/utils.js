// export async function validateFields(...fields) {
//     const promises = fields.map(f => {
//         return new Promise((res, rej) => {
//             f.validate = res
//         });
//     });
//     return Promise.all(promises)
// }
//
// import Vue from 'vue';
// import RenderString from '../components/render_string.vue'
// export function renderString(template, data) {
//     const ComponentClass = Vue.extend(RenderString);
//     const instance = new ComponentClass({
//         propsData: { string: template, data }
//     });
//     instance.$mount()
//     return instance
// }
//
// // Convert query object from query builder
// // into a more compact one for our backend
// export function query_to_rules(query) {
//   let computed_rules = {}
//   if (query) {
//     computed_rules['op'] = query.logicalOperator
//     computed_rules['queries'] = []
//     query.children.forEach(
//       (child) => {
//         if (child.type == "query-builder-rule") {
//           computed_rules['queries'].push(
//             [
//               child.query.rule,
//               child.query.operator ? child.query.operator : '=',
//               child.query.value
//             ]
//           )
//         } else {
//           computed_rules['queries'].push(
//             query_to_rules(child.query)
//           )
//         }
//       }
//     )
//   }
//
//   return computed_rules
// }
//
// import { DateTime } from 'luxon';
//
// // date formats are stupid
// export const dateToEnUsFormat = (date) => {
//   if(!date) return date;
//   return DateTime.fromISO(date).toFormat('D', {locale: "en-US"})
// }
