// NOTE: do not use this as it is very very very slow
// export const getOrderedRelationships = (relationship_name, target) => {
//   // This is bad code
//   if (!target) return [];
//   let rel_objects = target[relationship_name];
//   if (!rel_objects || !Object.keys(rel_objects).length) return [];
//   let sortFunc;
//   if(rel_objects[Object.keys(rel_objects)[0]].sort_order !== undefined) {
//     // sort order first
//     sortFunc = (a, b) => a.sort_order - b.sort_order
//   } else if(target._jv.relationships?.[relationship_name]) {
//     let order = target._jv.relationships[relationship_name].data.map(i => i.id);
//     sortFunc = (a, b) => order.indexOf(a.id) - order.indexOf(b.id)
//   } else {
//     // last resort, no sorting
//     sortFunc = (a, b) => 0
//   }
//   return Object.values(rel_objects).sort(sortFunc);
// }

export const getId = (itemOrId) => {
  try {
    return itemOrId.id || itemOrId;
  } catch {
    return itemOrId;
  }
}
