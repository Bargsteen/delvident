"use strict";

const faunadb = require('faunadb'),
  q = faunadb.query

var client = null;

exports.init = function (secret) {
  return function () {
    client = new faunadb.Client({ secret: secret });
  }
};

exports.createEntry = function (collectionName) {
  return function (newData) {
    return function () {
      client.query(
        q.Create(
          q.Collection(collectionName),
          { data: newData }
        )
      )
    }
  }
}

const createEntryWithId = (id, entry) => {
  var o = new Object();
  o.id = id;
  o.entry = entry;
  return o;
}

exports._fetchAllEntriesWithIds = function (collectionName) {
  return function () {
    return client.query(
      q.Map(
        q.Paginate(q.Documents(q.Collection(collectionName))),
        q.Lambda("e", q.Get(q.Var("e")))
      )
    ).then((response) => response.data.map(e => createEntryWithId(e.ref.value.id, e.data)));
  }
}