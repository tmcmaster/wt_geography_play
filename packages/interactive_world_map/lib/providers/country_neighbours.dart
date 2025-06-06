import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryNeighboursProvider = Provider<Map<String, List<String>>>(
  name: 'Country Neighbours',
  (ref) => {
    "Afghanistan": [
      "China",
      "Iran",
      "Pakistan",
      "Tajikistan",
      "Turkmenistan",
      "Uzbekistan"
    ],
    "Albania": ["Greece", "Kosovo", "North Macedonia", "Montenegro"],
    "Algeria": [
      "Libya",
      "Mali",
      "Mauritania",
      "Morocco",
      "Niger",
      "Tunisia",
      "Western Sahara"
    ],
    "Andorra": ["France", "Spain"],
    "Angola": [
      "Democratic Republic of the Congo",
      "Republic of the Congo",
      "Namibia",
      "Zambia"
    ],
    "Antarctica": ["Australia", "New Zealand", "Chile", "South Africa"],
    "Argentina": ["Bolivia", "Brazil", "Chile", "Paraguay", "Uruguay"],
    "Armenia": ["Azerbaijan", "Georgia", "Iran", "Turkey"],
    "Australia": ["New Zealand", "Papua New Guinea", "Antarctica"],
    "Austria": [
      "Czech Republic",
      "Germany",
      "Hungary",
      "Italy",
      "Liechtenstein",
      "Slovakia",
      "Slovenia",
      "Switzerland"
    ],
    "Azerbaijan": ["Armenia", "Georgia", "Iran", "Russia", "Turkey"],
    "The Bahamas": ["USA", "Cuba", "Haiti", "Dominican Republic"],
    "Bahrain": [],
    "Bangladesh": ["India, including Dahagram", "Myanmar"],
    "Barbados": [],
    "Belarus": ["Latvia", "Lithuania", "Poland", "Russia", "Ukraine"],
    "Belgium": ["France", "Germany", "Luxembourg", "Netherlands"],
    "Belize": ["Guatemala", "Mexico"],
    "Benin": ["Burkina Faso", "Niger", "Nigeria", "Togo"],
    "Bhutan": ["China", "India"],
    "Bolivia": ["Argentina", "Brazil", "Chile", "Paraguay", "Peru"],
    "Bosnia and Herzegovina": ["Croatia", "Montenegro", "Republic of Serbia"],
    "Botswana": ["Namibia", "South Africa", "Zambia", "Zimbabwe"],
    "Brazil": [
      "Argentina",
      "Bolivia",
      "Colombia",
      "French Guiana[15], (France)",
      "Guyana",
      "Paraguay",
      "Peru",
      "Suriname",
      "Uruguay",
      "Venezuela"
    ],
    "Brunei": ["Malaysia"],
    "Bulgaria": [
      "Greece",
      "North Macedonia",
      "Romania",
      "Republic of Serbia",
      "Turkey"
    ],
    "Burkina Faso": [
      "Benin",
      "Côte d'Ivoire",
      "Ghana",
      "Mali",
      "Niger",
      "Togo"
    ],
    "Burundi": [
      "Democratic Republic of the Congo",
      "Rwanda",
      "United Republic of Tanzania"
    ],
    "Cambodia": ["Laos", "Thailand", "Vietnam"],
    "Cameroon": [
      "Central African Republic",
      "Chad",
      "Republic of the Congo",
      "Equatorial Guinea",
      "Gabon",
      "Nigeria"
    ],
    "Canada": ["USA", "Greenland"],
    "Cape Verde": [],
    "Central African Republic": [
      "Cameroon",
      "Chad",
      "Democratic Republic of the Congo",
      "Republic of the Congo",
      "South Sudan",
      "Sudan"
    ],
    "Chad": [
      "Cameroon",
      "Central African Republic",
      "Libya",
      "Niger",
      "Nigeria",
      "Sudan"
    ],
    "Chile": ["Argentina", "Bolivia", "Peru", "Antarctica"],
    "China": [
      "Afghanistan",
      "Bhutan",
      "India",
      "Kazakhstan",
      "North Korea",
      "Kyrgyzstan",
      "Laos",
      "Mongolia",
      "Myanmar",
      "Nepal",
      "Pakistan",
      "Russia",
      "Tajikistan",
      "Vietnam"
    ],
    "Colombia": ["Brazil", "Ecuador", "Panama", "Peru", "Venezuela"],
    "Comoros": [],
    "Democratic Republic of the Congo": [
      "Angola",
      "Burundi",
      "Central African Republic",
      "Republic of the Congo",
      "Rwanda",
      "South Sudan",
      "United Republic of Tanzania",
      "Uganda",
      "Zambia"
    ],
    "Republic of the Congo": [
      "Angola",
      "Cameroon",
      "Central African Republic",
      "Democratic Republic of the Congo",
      "Gabon"
    ],
    "Costa Rica": ["Nicaragua", "Panama"],
    "Côte d'Ivoire": ["Burkina Faso", "Ghana", "Guinea", "Liberia", "Mali"],
    "Croatia": [
      "Bosnia and Herzegovina",
      "Hungary",
      "Montenegro",
      "Republic of Serbia",
      "Slovenia"
    ],
    "Cuba": [],
    "Cyprus": ["Greece", "Turkey", "Northern Cyprus"],
    "Czech Republic": ["Austria", "Germany", "Poland", "Slovakia"],
    "Denmark": ["Germany"],
    "Djibouti": ["Eritrea", "Ethiopia", "Somaliland"],
    "Dominica": [],
    "Dominican Republic": ["Haiti"],
    "East Timor": ["Indonesia"],
    "Ecuador": ["Colombia", "Peru"],
    "Egypt": ["Gaza Strip (State of Palestine)", "Israel", "Libya", "Sudan"],
    "El Salvador": ["Guatemala", "Honduras"],
    "Equatorial Guinea": ["Cameroon", "Gabon"],
    "Eritrea": ["Djibouti", "Ethiopia", "Sudan"],
    "Estonia": ["Latvia", "Russia"],
    "Eswatini": ["Mozambique", "South Africa"],
    "Ethiopia": [
      "Djibouti",
      "Eritrea",
      "Kenya",
      "Somalia",
      "South Sudan",
      "Sudan",
      "Yemen"
    ],
    "Falkland Islands": [],
    "Fiji": [],
    "Finland": ["Norway", "Sweden", "Russia"],
    "France": [
      "Belgium",
      "Brazil",
      "Germany",
      "Italy",
      "Luxembourg",
      "Monaco",
      "Netherlands",
      "Spain",
      "Suriname",
      "Switzerland"
    ],
    "French Southern and Antarctic Lands": [],
    "Gabon": ["Cameroon", "Republic of the Congo", "Equatorial Guinea"],
    "Gambia": ["Senegal"],
    "Georgia": [
      "Armenia",
      "Azerbaijan",
      "Russia",
      "Turkey",
      "Abkhazia",
      "South Ossetia"
    ],
    "Germany": [
      "Austria",
      "Belgium",
      "Czech Republic",
      "Denmark",
      "France",
      "Luxembourg",
      "Netherlands",
      "Poland",
      "Switzerland"
    ],
    "Ghana": ["Burkina Faso", "Côte d'Ivoire", "Togo"],
    "Greece": ["Albania", "Bulgaria", "Turkey", "North Macedonia", "Cyprus"],
    "Greenland": ["Canada", "Iceland"],
    "Grenada": [],
    "Guatemala": ["Belize", "El Salvador", "Honduras", "Mexico"],
    "Guinea": [
      "Côte d'Ivoire",
      "Guinea",
      "Liberia",
      "Mali",
      "Senegal",
      "Sierra Leone",
      "Bissau",
      "Guinea",
      "Senegal"
    ],
    "Guinea Bissau": [],
    "Guyana": ["Brazil", "Suriname", "Venezuela"],
    "Haiti": ["Dominican Republic"],
    "Honduras": ["Guatemala", "El Salvador", "Nicaragua"],
    "Hong Kong": ["China"],
    "Hungary": [
      "Austria",
      "Croatia",
      "Romania",
      "Republic of Serbia",
      "Slovakia",
      "Slovenia",
      "Ukraine"
    ],
    "Iceland": ["Greenland", "Ireland"],
    "India": [
      "Bangladesh",
      "Bhutan",
      "China",
      "Myanmar",
      "Nepal",
      "Pakistan",
      "Sri Lanka"
    ],
    "Indonesia": ["East Timor", "Malaysia", "Papua New Guinea", "Philippines"],
    "Iran": [
      "Afghanistan",
      "Armenia",
      "Azerbaijan",
      "Iraq",
      "Pakistan",
      "Turkey",
      "Turkmenistan"
    ],
    "Iraq": ["Iran", "Jordan", "Kuwait", "Saudi Arabia", "Syria", "Turkey"],
    "Ireland": ["England", "Iceland"],
    "Israel": [
      "Egypt",
      "Gaza Strip (State of Palestine)",
      "Jordan",
      "Lebanon",
      "Syria",
      "West Bank (state of Palestine)"
    ],
    "Italy": [
      "Austria",
      "France",
      "Malta",
      "San Marino",
      "Slovenia",
      "Switzerland",
      "Vatican City"
    ],
    "Ivory Coast": ["Liberia", "Mali", "Ghana", "Burkina Faso"],
    "Jamaica": [],
    "Japan": ["Russia", "South Korea"],
    "Jordan": [
      "Iraq",
      "Israel",
      "Saudi Arabia",
      "Syria",
      "West Bank (State of Palestine)"
    ],
    "Kazakhstan": [
      "China",
      "Kyrgyzstan",
      "Russia",
      "Turkmenistan",
      "Uzbekistan"
    ],
    "Kenya": [
      "Ethiopia",
      "Somalia",
      "South Sudan",
      "United Republic of Tanzania",
      "Uganda"
    ],
    "Kiribati": [],
    "North Korea": ["China", "South Korea", "Russia"],
    "South Korea": ["North Korea", "Japan"],
    "Kosovo": [
      "Albania",
      "Montenegro",
      "North Macedonia",
      "Republic of Serbia"
    ],
    "Kuwait": ["Iraq", "Saudi Arabia"],
    "Kyrgyzstan": ["China", "Kazakhstan", "Tajikistan", "Uzbekistan"],
    "Laos": ["Cambodia", "China", "Myanmar", "Thailand", "Vietnam"],
    "Latvia": ["Belarus", "Estonia", "Lithuania", "Russia"],
    "Lebanon": ["Israel", "Syria"],
    "Lesotho": ["South Africa"],
    "Liberia": ["Guinea", "Côte d'Ivoire", "Sierra Leone", "Ivory Coast"],
    "Libya": ["Algeria", "Chad", "Egypt", "Niger", "Sudan", "Tunisia"],
    "Liechtenstein": ["Austria", "Switzerland"],
    "Lithuania": ["Belarus", "Latvia", "Poland", "Russia"],
    "Luxembourg": ["Belgium", "France", "Germany"],
    "Macedonia": [],
    "Madagascar": ["Mozambique"],
    "Malawi": ["Mozambique", "United Republic of Tanzania", "Zambia"],
    "Malaysia": ["Brunei", "Indonesia", "Thailand", "Philippines"],
    "Maldives": [],
    "Mali": [
      "Algeria",
      "Burkina Faso",
      "Côte d'Ivoire",
      "Guinea",
      "Mauritania",
      "Niger",
      "Senegal"
    ],
    "Malta": ["Italy"],
    "Mauritania": ["Algeria", "Mali", "Senegal", "Western Sahara"],
    "Mauritius": [],
    "Mexico": ["Belize", "Guatemala", "USA"],
    "Moldova": ["Romania", "Ukraine"],
    "Monaco": ["France"],
    "Mongolia": ["China", "Russia"],
    "Montenegro": [
      "Albania",
      "Bosnia and Herzegovina",
      "Croatia",
      "Kosovo",
      "Republic of Serbia"
    ],
    "Morocco": ["Algeria", "Western Sahara", "Spain"],
    "Mozambique": [
      "Eswatini",
      "Madagascar",
      "Malawi",
      "South Africa",
      "United Republic of Tanzania",
      "Zambia",
      "Zimbabwe"
    ],
    "Myanmar": ["Bangladesh", "China", "India", "Laos", "Thailand"],
    "Namibia": ["Angola", "Botswana", "South Africa", "Zambia"],
    "Nauru": [],
    "Nepal": ["China", "India"],
    "Netherlands": ["Belgium", "Germany"],
    "New Zealand": ["Australia", "Antarctica"],
    "Nicaragua": ["Costa Rica", "Honduras"],
    "New Caledonia": [],
    "Niger": [
      "Algeria",
      "Benin",
      "Burkina Faso",
      "Chad",
      "Libya",
      "Mali",
      "Nigeria"
    ],
    "Nigeria": ["Benin", "Cameroon", "Chad", "Niger"],
    "Northern Cyprus": ["Turkey", "Cyprus", "Greece"],
    "North Macedonia": [
      "Albania",
      "Bulgaria",
      "Greece",
      "Kosovo",
      "Republic of Serbia"
    ],
    "Norway": ["Finland", "Sweden", "Russia"],
    "Oman": ["Saudi Arabia", "United Arab Emirates", "Yemen"],
    "Pakistan": ["Afghanistan", "India", "Iran", "China"],
    "Palau": [],
    "Palestine": ["Egypt", "Israel", "Jordan"],
    "Panama": ["Colombia", "Costa Rica"],
    "Papua New Guinea": ["Indonesia"],
    "Paraguay": ["Argentina", "Bolivia", "Brazil"],
    "Peru": ["Bolivia", "Brazil", "Chile", "Colombia", "Ecuador"],
    "Philippines": ["Malaysia", "Indonesia"],
    "Poland": [
      "Belarus",
      "Czech Republic",
      "Germany",
      "Lithuania",
      "Russia",
      "Slovakia",
      "Ukraine"
    ],
    "Puerto Rico": [],
    "Portugal": ["Spain", "Morocco"],
    "Qatar": ["Saudi Arabia"],
    "Romania": [
      "Bulgaria",
      "Hungary",
      "Moldova",
      "Republic of Serbia",
      "Ukraine"
    ],
    "Russia": [
      "Azerbaijan",
      "Belarus",
      "China",
      "Estonia",
      "Finland",
      "Georgia",
      "Japan",
      "Kazakhstan",
      "North Korea",
      "Latvia",
      "Lithuania",
      "Mongolia",
      "Norway",
      "Poland",
      "Ukraine"
    ],
    "Rwanda": [
      "Burundi",
      "Democratic Republic of the Congo",
      "United Republic of Tanzania",
      "Uganda"
    ],
    "San Marino": ["Italy"],
    "Saudi Arabia": [
      "Iraq",
      "Jordan",
      "Kuwait",
      "Oman",
      "Qatar",
      "United Arab Emirates",
      "Yemen"
    ],
    "Senegal": ["Gambia", "Guinea", "Guinea", "Mali", "Mauritania"],
    "Republic of Serbia": [
      "Bosnia and Herzegovina",
      "Bulgaria",
      "Croatia",
      "Hungary",
      "Kosovo",
      "Montenegro",
      "North Macedonia",
      "Romania"
    ],
    "Sierra Leone": ["Guinea", "Liberia"],
    "Singapore": [],
    "Slovakia": ["Austria", "Czech Republic", "Hungary", "Poland", "Ukraine"],
    "Slovenia": ["Austria", "Croatia", "Italy", "Hungary"],
    "Solomon Islands": [],
    "Somaliland": [],
    "Somalia": ["Djibouti", "Ethiopia", "Kenya"],
    "South Africa": [
      "Botswana",
      "Eswatini",
      "Lesotho",
      "Mozambique",
      "Namibia",
      "Zimbabwe",
      "Antarctica"
    ],
    "South Ossetia": ["Russia", "Georgia"],
    "South Sudan": [
      "Central African Republic",
      "Democratic Republic of the Congo",
      "Ethiopia",
      "Kenya",
      "Sudan",
      "Uganda"
    ],
    "Spain": ["Andorra", "France", "Gibraltar", "Portugal", "Morocco"],
    "Sri Lanka": ["India"],
    "Sudan": [
      "Central African Republic",
      "Chad",
      "Egypt",
      "Eritrea",
      "Ethiopia",
      "Libya",
      "South Sudan"
    ],
    "Suriname": ["Brazil", "French Guiana[15], (France)", "Guyana"],
    "Swaziland": [],
    "Sweden": ["Finland", "Norway"],
    "Switzerland": ["Austria", "France", "Italy", "Liechtenstein", "Germany"],
    "Syria": ["Iraq", "Israel", "Jordan", "Lebanon", "Turkey"],
    "Taiwan": [],
    "Tajikistan": ["Afghanistan", "China", "Kyrgyzstan", "Uzbekistan"],
    "United Republic of Tanzania": [
      "Burundi",
      "Democratic Republic of the Congo",
      "Kenya",
      "Malawi",
      "Mozambique",
      "Rwanda",
      "Uganda",
      "Zambia"
    ],
    "Thailand": ["Cambodia", "Laos", "Malaysia", "Myanmar"],
    "Togo": ["Benin", "Burkina Faso", "Ghana"],
    "Tonga": [],
    "Trinidad and Tobago": [],
    "Tunisia": ["Algeria", "Libya"],
    "Turkey": [
      "Armenia",
      "Azerbaijan",
      "Bulgaria",
      "Georgia",
      "Greece",
      "Iran",
      "Iraq",
      "Syria"
    ],
    "Turkmenistan": ["Afghanistan", "Iran", "Kazakhstan", "Uzbekistan"],
    "Tuvalu": [],
    "Uganda": [
      "Democratic Republic of the Congo",
      "Kenya",
      "Rwanda",
      "South Sudan",
      "United Republic of Tanzania"
    ],
    "Ukraine": [
      "Belarus",
      "Hungary",
      "Moldova",
      "Poland",
      "Romania",
      "Russia",
      "Slovakia"
    ],
    "United Arab Emirates": ["Oman", "Saudi Arabia"],
    "England": [
      "Ireland",
      "Iceland",
      "France",
      "Belgium",
      "Belgium",
      "Netherlands"
    ],
    "USA": ["Canada", "Mexico"],
    "Uruguay": ["Argentina", "Brazil"],
    "Uzbekistan": [
      "Afghanistan",
      "Kazakhstan",
      "Kyrgyzstan",
      "Tajikistan",
      "Turkmenistan"
    ],
    "Vatican City": ["Italy"],
    "Venezuela": ["Brazil", "Colombia", "Guyana"],
    "Vanuatu": [],
    "Vietnam": ["Cambodia", "China", "Laos"],
    "West Bank": [],
    "Western Sahara": ["Algeria", "Mauritania", "Morocco"],
    "Yemen": ["Oman", "Saudi Arabia", "Ethiopia"],
    "Zambia": [
      "Angola",
      "Botswana",
      "Democratic Republic of the Congo",
      "Malawi",
      "Mozambique",
      "Namibia",
      "United Republic of Tanzania",
      "Zimbabwe"
    ],
    "Zimbabwe": ["Botswana", "Mozambique", "South Africa", "Zambia"]
  },
);
