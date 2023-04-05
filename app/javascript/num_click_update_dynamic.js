$(document).ready(function () {
  $("#click-button").on("click", function () {
    $.ajax({
      url: "/update_num_clicks",
      type: "POST",
      dataType: "json",
      success: function (response) {
        $("#num-clicks").text(response.num_clicks);
        window.location.href = response.redirect_url;
      },
      error: function () {
        alert("Error updating click count");
      },
    });
  });
});
