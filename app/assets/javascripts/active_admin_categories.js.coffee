window.registerAdminCategoryBoxes = ()->
  $('.admin_category_box').change (e)->
    obj = $(e.target)
    $.getJSON '/bunnies?model='+obj.attr('data-model')+'&id='+obj.val(), (data) ->
      div = obj.next()
      if data['count'] > 0
        html = '<select data-model="'+obj.attr('data-model')+'" class="admin_category_box">'
        $.each data['categories'], (i,e) ->
          html += '<option value="'+e+'">'+i+'</option>'
        html += '</select>'
        html += '<div class="subs"></div>'
        div.html(html)
        window.registerAdminCategoryBoxes()
    $('#category_'+obj.attr('data-model')).val( obj.val() )
    $.getJSON '/bunnies/'+obj.val()+'.json?model='+obj.attr('data-model'), (data)->
      $('#selected_'+data['model']).html( data['label'] )

window.submitCategory = ()->
  params = {}
  $('input').each (i,e)->
    obj = $(e)
    console.log(obj)
    name = obj.attr('name')
    if (name && name.substring(0, 9) == 'category_')
      params[name] = obj.val()
  $.post '/bunnies.json?business_id='+$('#business_id').val(),
    params,
    (data)->
      if data['status'] == 'success'
        $('#categorized').html('Categorized')
      else
        $('#categorized').html(data['errors'])

$(document).ready ->
  window.registerAdminCategoryBoxes()
