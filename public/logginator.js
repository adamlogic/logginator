$(function() {

  $('#summaries tr').live('click', clearDetail).live('click', selectRow);
  $('form#search').submit(clearSummaries);

  function clearDetail(e) {
    $('#detail').empty();
  }

  function clearSummaries(e) {
    $('#summaries').empty();
  }

  function selectRow(e) {
    $(this).closest('table').find('tr.selected').removeClass('selected');
    $(this).addClass('selected');
  }

});
