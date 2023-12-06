var VerificationCheck = {
  verificar_campos: function(){
    let g_check = $("#ratings_G");
    if (!g_check.is(":checked")) {
      $(".G").hide();
    }
    let pg_check = $("#ratings_PG");
    if (!pg_check.is(":checked")) {
      $(".PG").hide();
    }
    let pg13_check = $("#ratings_PG-13");
    if (!pg13_check.is(":checked")) {
      $(".PG-13").hide();
    }
    let r_check = $("#ratings_R");
    if (!r_check.is(":checked")) {
      $(".R").hide();
    }
  },
  setup: function () {
    $(document).on('submit', '#rating_submit', VerificationCheck.verificar_campos);
  },
};
$(VerificationCheck.setup);
