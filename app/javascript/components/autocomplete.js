import "typeahead.js";
import Bloodhound from "bloodhound-js"

const initializeAutocomplete = () => {
  const createBloodHound = (namesId, name) => {
    return new Bloodhound({
      queryTokenizer: Bloodhound.tokenizers.whitespace, // input is split into words by whitespace
      datumTokenizer: Bloodhound.tokenizers.whitespace, // value at field name in data is cut in words by whitespace
      local: JSON.parse(document.getElementById(namesId).dataset.names) // data, passed in json by ruby through html
    });
  }

  const charities = createBloodHound("charity-names")
  const cities = createBloodHound("cities-names")
  const provinces = createBloodHound("provinces-names")
  const categories = createBloodHound("categories-names")

  $('#the-basics .typeahead').typeahead(
  {
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'charities',
    source: charities,
    templates: {
      header: '<h3 class="league-name">Charities</h3>'
    }
  },
  {
    name: 'cities',
    source: cities,
    templates: {
      header: '<h3 class="league-name">Cities</h3>'
    }
  },
  {
    name: 'provinces',
    source: provinces,
    templates: {
      header: '<h3 class="league-name">Province</h3>'
    }
  },
  {
    name: 'categories',
    source: categories,
    templates: {
      header: '<h3 class="league-name">Categories</h3>'
    }
  }
  );
}







export { initializeAutocomplete };
