final List countries = List.unmodifiable([
  "Afghanistan",
  "Ägypten",
  "Albanien",
  "Algerien",
  "Andorra",
  "Angola",
  "Antigua",
  "Äquatorialguinea",
  "Argentinien",
  "Armenien",
  "Aserbaidschan",
  "Äthiopien",
  "Australien",
  "Bahamas",
  "Bahrain",
  "Bangladesch",
  "Barbados",
  "Belarus",
  "Belgien",
  "Belize",
  "Benin",
  "Bhutan",
  "Bolivien",
  "Bosnien",
  "Botsuana",
  "Brasilien",
  "Brunei",
  "Bulgarien",
  "Burkina",
  "Burundi",
  "Cabo Verde",
  "Chile",
  "China",
  "Cookinseln",
  "Costa Rica",
  "Côte d'Ivoire",
  "Dänemark",
  "Deutschland",
  "Dominica",
  "Dominikanische Republik",
  "Dschibuti",
  "Ecuador",
  "El Salvador",
  "Eritrea",
  "Estland",
  "Eswatini",
  "Fidschi",
  "Finnland",
  "Frankreich",
  "Gabun",
  "Gambia",
  "Georgien",
  "Ghana",
  "Grenada",
  "Griechenland",
  "Großbritannien",
  "Guatemala",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Honduras",
  "Indien",
  "Indonesien",
  "Irak",
  "Iran",
  "Irland",
  "Island",
  "Israel",
  "Italien",
  "Jamaika",
  "Japan",
  "Jemen",
  "Jordanien",
  "Kambodscha",
  "Kamerun",
  "Kanada",
  "Kasachstan",
  "Katar",
  "Kenia",
  "Kirgisistan",
  "Kiribati",
  "Kolumbien",
  "Komoren",
  "Kongo",
  "Nordkorea",
  "Südkorea",
  "Kosovo",
  "Kroatien",
  "Kuba",
  "Kuwait",
  "Laos",
  "Lesotho",
  "Lettland",
  "Libanon",
  "Liberia",
  "Libyen",
  "Liechtenstein",
  "Litauen",
  "Luxemburg",
  "Madagaskar",
  "Malawi",
  "Malaysia",
  "Malediven",
  "Mali",
  "Malta",
  "Marokko",
  "Marshallinseln",
  "Mauretanien",
  "Mauritius",
  "Mexiko",
  "Mikronesien",
  "Moldau",
  "Monaco",
  "Mongolei",
  "Montenegro",
  "Mosambik",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Neuseeland",
  "Nicaragua",
  "Niederlande",
  "Niger",
  "Nigeria",
  "Niue",
  "Nordmazedonien",
  "Norwegen",
  "Oman",
  "Österreich",
  "Pakistan",
  "Palau",
  "Panama",
  "Papua-Neuguinea",
  "Paraguay",
  "Peru",
  "Philippinen",
  "Polen",
  "Portugal",
  "Ruanda",
  "Rumänien",
  "Russland",
  "Salomonen",
  "Sambia",
  "Samoa",
  "San Marino",
  "São Tomé",
  "Saudi-Arabien",
  "Schweden",
  "Schweiz",
  "Senegal",
  "Serbien",
  "Seychellen",
  "Sierra",
  "Simbabwe",
  "Singapur",
  "Slowakei",
  "Slowenien",
  "Somalia",
  "Spanien",
  "Sri Lanka",
  "St. Kitts",
  "St. Lucia",
  "St. Vincent und die Grenadinen",
  "Südafrika",
  "Sudan",
  "Südsudan",
  "Suriname",
  "Syrien",
  "Tadschikistan",
  "Tansania",
  "Thailand",
  "Timor-Leste",
  "Togo",
  "Tonga",
  "Trinidad und Tobago",
  "Tschad",
  "Tschechien",
  "Tunesien",
  "Türkei",
  "Turkmenistan",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "Ungarn",
  "Uruguay",
  "Usbekistan",
  "Vanuatu",
  "Vatikanstadt",
  "Venezuela",
  "Vereinigte Staaten von Amerika",
  "Vietnam",
  "Weißrussland",
  "Zentralafrikanische Republik",
  "Zypern",
]);

final Map<String, String> countryCodes = {
  "Afghanistan": "AF",
  "Ägypten": "EG",
  "Albanien": "AL",
  "Algerien": "DZ",
  "Andorra": "AD",
  "Angola": "AO",
  "Anguilla": "AI",
  "Antarktis": "AQ",
  "Antigua und Barbuda": "AG",
  "Äquatorial Guinea": "GQ",
  "Argentinien": "AR",
  "Armenien": "AM",
  "Aruba": "AW",
  "Aserbaidschan": "AZ",
  "Äthiopien": "ET",
  "Australien": "AU",
  "Bahamas": "BS",
  "Bahrain": "BH",
  "Bangladesh": "BD",
  "Barbados": "BB",
  "Belgien": "BE",
  "Belize": "BZ",
  "Benin": "BJ",
  "Bermudas": "BM",
  "Bhutan": "BT",
  "Birma": "MM",
  "Bolivien": "BO",
  "Bosnien-Herzegowina": "BA",
  "Botswana": "BW",
  "Bouvet Inseln": "BV",
  "Brasilien": "BR",
  "Britisch-Indischer Ozean": "IO",
  "Brunei": "BN",
  "Bulgarien": "BG",
  "Burkina Faso": "BF",
  "Burundi": "BI",
  "Chile": "CL",
  "China": "CN",
  "Christmas Island": "CX",
  "Cook Inseln": "CK",
  "Costa Rica": "CR",
  "Dänemark": "DK",
  "Deutschland": "DE",
  "Djibuti": "DJ",
  "Dominika": "DM",
  "Dominikanische Republik": "DO",
  "Ecuador": "EC",
  "El Salvador": "SV",
  "Elfenbeinküste": "CI",
  "Eritrea": "ER",
  "Estland": "EE",
  "Falkland Inseln": "FK",
  "Färöer Inseln": "FO",
  "Fidschi": "FJ",
  "Finnland": "FI",
  "Frankreich": "FR",
  "französisch Guyana": "GF",
  "Französisch Polynesien": "PF",
  "Französisches Süd-Territorium": "TF",
  "Gabun": "GA",
  "Gambia": "GM",
  "Georgien": "GE",
  "Ghana": "GH",
  "Gibraltar": "GI",
  "Grenada": "GD",
  "Griechenland": "GR",
  "Grönland": "GL",
  "Großbritannien": "UK",
  "Guadeloupe": "GP",
  "Guam": "GU",
  "Guatemala": "GT",
  "Guinea": "GN",
  "Guinea Bissau": "GW",
  "Guyana": "GY",
  "Haiti": "HT",
  "Heard und McDonald Islands": "HM",
  "Honduras": "HN",
  "Hong Kong": "HK",
  "Indien": "IN",
  "Indonesien": "ID",
  "Irak": "IQ",
  "Iran": "IR",
  "Irland": "IE",
  "Island": "IS",
  "Israel": "IL",
  "Italien": "IT",
  "Jamaika": "JM",
  "Japan": "JP",
  "Jemen": "YE",
  "Jordanien": "JO",
  "Jugoslawien": "YU",
  "Kaiman Inseln": "KY",
  "Kambodscha": "KH",
  "Kamerun": "CM",
  "Kanada": "CA",
  "Kap Verde": "CV",
  "Kasachstan": "KZ",
  "Kenia": "KE",
  "Kirgisistan": "KG",
  "Kiribati": "KI",
  "Kokosinseln": "CC",
  "Kolumbien": "CO",
  "Komoren": "KM",
  "Kongo": "CG",
  "Demokratische Republik Kongo": "CD",
  "Kroatien": "HR",
  "Kuba": "CU",
  "Kuwait": "KW",
  "Laos": "LA",
  "Lesotho": "LS",
  "Lettland": "LV",
  "Libanon": "LB",
  "Liberia": "LR",
  "Libyen": "LY",
  "Liechtenstein": "LI",
  "Litauen": "LT",
  "Luxemburg": "LU",
  "Macao": "MO",
  "Madagaskar": "MG",
  "Malawi": "MW",
  "Malaysia": "MY",
  "Malediven": "MV",
  "Mali": "ML",
  "Malta": "MT",
  "Marianen": "MP",
  "Marokko": "MA",
  "Marshall Inseln": "MH",
  "Martinique": "MQ",
  "Mauretanien": "MR",
  "Mauritius": "MU",
  "Mayotte": "YT",
  "Mazedonien": "MK",
  "Mexiko": "MX",
  "Mikronesien": "FM",
  "Mocambique": "MZ",
  "Moldavien": "MD",
  "Monaco": "MC",
  "Mongolei": "MN",
  "Montserrat": "MS",
  "Namibia": "NA",
  "Nauru": "NR",
  "Nepal": "NP",
  "Neukaledonien": "NC",
  "Neuseeland": "NZ",
  "Nicaragua": "NI",
  "Niederlande": "NL",
  "Niederländische Antillen": "AN",
  "Niger": "NE",
  "Nigeria": "NG",
  "Niue": "NU",
  "Nord Korea": "KP",
  "Norfolk Inseln": "NF",
  "Norwegen": "NO",
  "Oman": "OM",
  "Österreich": "AT",
  "Pakistan": "PK",
  "Palästina": "PS",
  "Palau": "PW",
  "Panama": "PA",
  "Papua Neuguinea": "PG",
  "Paraguay": "PY",
  "Peru": "PE",
  "Philippinen": "PH",
  "Pitcairn": "PN",
  "Polen": "PL",
  "Portugal": "PT",
  "Puerto Rico": "PR",
  "Qatar": "QA",
  "Reunion": "RE",
  "Ruanda": "RW",
  "Rumänien": "RO",
  "Russland": "RU",
  "Saint Lucia": "LC",
  "Sambia": "ZM",
  "Samoa": "AS",
  "San Marino": "SM",
  "Sao Tome": "ST",
  "Saudi Arabien": "SA",
  "Schweden": "SE",
  "Schweiz": "CH",
  "Senegal": "SN",
  "Seychellen": "SC",
  "Sierra Leone": "SL",
  "Singapur": "SG",
  "Slowakei": "SK",
  "Slowenien": "SI",
  "Solomon Inseln": "SB",
  "Somalia": "SO",
  "Südgeorgien und die Südlichen Sandwichinseln": "GS",
  "Spanien": "ES",
  "Sri Lanka": "LK",
  "St. Helena": "SH",
  "St. Kitts Nevis Anguilla": "KN",
  "St. Pierre und Miquelon": "PM",
  "St. Vincent": "VC",
  "Süd Korea": "KR",
  "Südafrika": "ZA",
  "Sudan": "SD",
  "Surinam": "SR",
  "Svalbard und Jan Mayen Islands": "SJ",
  "Swasiland": "SZ",
  "Syrien": "SY",
  "Tadschikistan": "TJ",
  "Taiwan": "TW",
  "Tansania": "TZ",
  "Thailand": "TH",
  "Timor": "TP",
  "Togo": "TG",
  "Tokelau": "TK",
  "Tonga": "TO",
  "Trinidad Tobago": "TT",
  "Tschad": "TD",
  "Tschechische Republik": "CZ",
  "Tunesien": "TN",
  "Türkei": "TR",
  "Turkmenistan": "TM",
  "Turks und Kaikos Inseln": "TC",
  "Tuvalu": "TV",
  "Uganda": "UG",
  "Ukraine": "UA",
  "Ungarn": "HU",
  "Uruguay": "UY",
  "Usbekistan": "UZ",
  "Vanuatu": "VU",
  "Vatikan": "VA",
  "Venezuela": "VE",
  "Vereinigte Arabische Emirate": "AE",
  "Vereinigte Staaten von Amerika": "US",
  "Vietnam": "VN",
  "Virgin Island": "VG",
  "Wallis et Futuna": "WF",
  "Weissrussland": "BY",
  "Westsahara": "EH",
  "Zentralafrikanische Republik": "CF",
  "Zimbabwe": "ZW",
  "Zypern": "CY"
};
