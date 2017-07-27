FARMA.findTeams = (query) ->
  $.ajax('/student/find_teams', {
    data: {query: query}
    dataType: 'json'
    success: (response) ->
      $('#box-teams').html('')
      for team in response.teams
        $('#box-teams').append(teamComponent(team, response.token))
  })

teamComponent = (team, token) ->
  cardContent = element('div', {class: 'card-content center'})
                        .append(element('span', {class: 'card-title'}, team.name))

  cardContentInformation = element('div', {class: 'card-content information center'})
                                  .append(element('p', {}, team.userName))
                                  .append(element('p', {}, team.createdAt))

  cardImage = element('div', {class: 'card-image'})
                      .append(element('img', {class: 'responsive-img', src: team.userImage, alt: 'User Avatar'}))

  teamDiv = element('div', {class: 'team'})
                    .append(element('div', {class: 'card'})
                    .append(cardContent)
                    .append(cardImage)
                    .append(cardContentInformation)
                    .append(isRegistered(team, token)))

  return element('div', {class: 'col s4'}).append(teamDiv)

isRegistered = (team, token) ->
  cardAction = element('div', {class: 'card-action center'}).append(element('a', {href: "/student/teams/#{team.id}"}, 'VISUALIZAR CONTEÚDO'))

  return cardAction if team.registered

  return element('div', {class: 'card-action center box-form'}).
                    append(formComponent(team, token))

formComponent = (team, token) ->
    inputToken = element('input', {name: 'authenticity_token', value: token, type: 'hidden'})
    inputField = element('div', {class: 'input-field'})
                        .append(element('input', {id: 'register_id', value: team.id, type: 'hidden', name: 'register[id]'}))
                        .append(element('input', {id: 'register_code', type: 'text', name: 'register[code]'}))
                        .append(element('label', {class: 'center_align'}, 'Insira a chave'))

    submit = element('i', {class: 'waves-effect waves-light btn white waves-input-wrapper'})
                    .append(element('input', {class: 'waves-button-input', type: 'submit', name: 'commit', value: 'inscrever-se'}))

    form = element('form', {id: "register_form_#{team.id}", action: '/student/teams', method: 'POST'})
                   .append(inputToken)
                   .append(inputField)
                   .append(submit)

    return form

element = (name, options, body) ->
  el = $("<#{name}></#{name}>")

  for k, v of options
    el.attr(k, v)

  if body
    el.text(body)

  return el
