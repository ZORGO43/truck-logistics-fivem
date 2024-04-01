$(function () {
    window.onload = _0x3efd8f => {
      $("#container").hide();
      $("#container2").hide();
      window.addEventListener("message", _0x335276 => {
        var _0x1bd860 = _0x335276.data;
        if (_0x1bd860 !== undefined && _0x1bd860.type === "ui") {
          if (_0x1bd860.display === true) {
            $("#container2").hide();
            $("#container").fadeIn();
          } else {
            $("#container").fadeOut();
          }
        }
        if (_0x1bd860 !== undefined && _0x1bd860.type === "uiCity") {
          if (_0x1bd860.display === true) {
            $("#container").hide();
            $("#container2").fadeIn();
          } else {
            $("#container2").fadeOut();
          }
        }
      });
      $("#lumber").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "lumber"
        }));
        $("#container").hide();
      });
      $("#mechanic").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "mechanic"
        }));
        $("#container").hide();
      });
      $("#goods").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "goods"
        }));
        $("#container").hide();
      });
      $("#fuel").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "fuel"
        }));
        $("#container2").hide();
      });
      $("#auto").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "auto"
        }));
        $("#container2").hide();
      });
      $("#paleto").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "paleto"
        }));
        $("#container2").hide();
      });
      $("#harbour").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "harbour"
        }));
        $("#container2").hide();
      });
      $("#stop1").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "stop"
        }));
        $("#container2").hide();
      });
      $("#kindi2").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "close"
        }));
        $("#container2").hide();
      });
      $("#kindi").click(function () {
        $.post("https://zorgo-logistics/action", JSON.stringify({
          action: "close"
        }));
        $("#container").hide();
      });
    };
  });