let refresh = async () => {
  let res = await fetch("/get-wifis");
  let wifis = await res.json();

  let wrapper = document.querySelector("#wifi-list");
  wrapper.innerHTML = "";

  wifis.sort((a, b) => (parseInt(a.strength) > parseInt(b.strength) ? -1 : 1));

  wifis.forEach((wifi) => {
    var node = document.createElement("div");
    node.classList.add("list-item");
    node.innerText = wifi.ssid;
    node.onclick = async () => {
      let key = prompt("Bitte geben Sie das Passwort ein");
      await saveWifi(wifi.ssid, key);

      // clean page
      document.querySelector("body").innerHTML = "<h1>Erledigt!</h1>";
    };

    wrapper.appendChild(node);
  });

  if (wifis.length < 1) {
    wrapper.innerHTML = "Keine WLAN-Netzwerke gefunden";
  }
};

let saveWifi = async (ssid, key) => {
  let data = {
    ssid: ssid,
    key: key,
  };

  await fetch("/save-config", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  });
};

refresh();
