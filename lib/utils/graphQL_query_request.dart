/*
  define query requests to graphQL client
 */

String queryGetCountriesInfo = r'''
query {
  countries {
    name
  }
}
''';

// https://rational-calf-16.hasura.app/v1/graphql
String queryGetPersons = r'''
query {
  persons (){
    personid
    address
    firstname,
    lastname
  }
}
''';

String mutationInsertPersons = r'''
mutation InsertPersons($personid: Int, $address: String, $firstname: String, $lastname: String) {
  insert_persons(objects: [{personid: $personid, address: $address, firstname: $firstname, lastname: $lastname}]) {
    returning {
      personid
      lastname
    }
  }
}
''';

String mutationUpdatePersons = r'''
mutation UpdatePersons($firstname: String) {
  update_persons(where: {personid: {_eq: 10}}, _set: {firstname: $firstname}) {
    returning {
      personid
      address
      firstname,
      lastname
    }
  }
}
''';

String mutationDeletePersons = r'''
mutation DeletePersons() {
  delete_persons(where: {personid: {_eq: 10}}) {
    returning {
      personid
      address
      firstname,
      lastname
    }
  }
}
''';
