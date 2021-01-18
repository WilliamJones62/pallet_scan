function getData(data) {
  var p1 = data.replace('[', "");
  var p2 = p1.replace(']', "");
  p1 = p2.replace(/"/g, "");
  p2 = p1.replace(/,/g, "");
  var data_array = p2.split(" ");
  data_array.shift();
  data_array.pop();
  return data_array;
}

function setToggle() {
  var cost_center = document.getElementById("cost_center").value;
  var i = 0;
  var x = document.getElementById("truck");
  while (x.options.length) {
    x.remove(0);
  }
  var y = document.getElementById("toggle_button");
  button_text = y.innerHTML;
  if (button_text == "Select Truck") {
    y.innerHTML = "Select Location";
    var truckccs = document.getElementById("jstruckccs").innerHTML;
    var truckccs_array = getData(truckccs);
    var trucks = document.getElementById("jstrucks").innerHTML;
    var trucks_array = getData(trucks);
    var arraylength = trucks_array.length;
    for (i = 0; i < arraylength; i++) {
      if (cost_center == truckccs_array[i]) {
      // exclude staging locations on new pallet screen
       var truck = new Option(trucks_array[i], trucks_array[i]);
       x.options.add(truck);
      }
    }
  }
  else {
    y.innerHTML = "Select Truck"
    var locationccs = document.getElementById("jslocationccs").innerHTML;
    var locationccs_array = getData(locationccs);
    var locations = document.getElementById("jslocations").innerHTML;
    var locations_array = getData(locations);
    var arraylength = locations_array.length;
    for (i = 0; i < arraylength; i++) {
      if (cost_center == locationccs_array[i]) {
      // exclude staging locations on new pallet screen
       var location = new Option(locations_array[i], locations_array[i]);
       x.options.add(location);
      }
    }
  }
}
