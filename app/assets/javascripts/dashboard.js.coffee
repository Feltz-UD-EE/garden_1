#
# Copyright 2015-2016 Prehab Technologies dba prenovo. All rights reserved.
#

$(document).ready ->

  $("#invite-new-patient-btn").click () ->
    reset_invite()

  $("#enroll-new-patient-btn").click () ->
    reset_enroll()

  $("#invite-patient a.close-reveal-modal").click () ->
    window.setTimeout(reset_invite, 500)

  $("#enroll-patient a.close-reveal-modal").click () ->
    window.setTimeout(reset_enroll, 500)

  $("#invite-user-form form").submit (event) ->
    event.preventDefault()
    event.stopPropagation()
    if $("#invitee-first-name").is('[data-invalid]') or
       $("#invitee-last-name").is('[data-invalid]') or
       $("#invitee-email").is('[data-invalid]') or
       $("#invitee-phone").is('[data-invalid]')
      return
    else
      action = this.action
      invitee = getInviteeInfo()
      submit_invite(action, invitee)
    
  $("#enroll-user-form form").submit (event) ->
    event.preventDefault()
    event.stopPropagation()
    if $("#enroll-first-name").is('[data-invalid]') or
       $("#enroll-last-name").is('[data-invalid]') or
       $("#enroll-email").is('[data-invalid]') or
       $("#enroll-phone").is('[data-invalid]') or
       $("#enroll-dob").is('[data-invalid]')             
      return
    else
      action = this.action
      submit_enroll(action)

  $("#careteam_id").change (event) ->
    $(this).closest('form').trigger('submit')

  getInviteeInfo = () ->
    invitee =
      first_name: document.getElementById("invitee-first-name").value
      last_name:  document.getElementById("invitee-last-name").value
      email:      document.getElementById("invitee-email").value
      phone:      document.getElementById("invitee-phone").value
    return invitee

  $("#invite-another").click (event) ->
    event.preventDefault()
    event.stopPropagation()
    reset_invite()

  $("#enroll-another").click (event) ->
    event.preventDefault()
    event.stopPropagation()
    reset_enroll()

   reset_invite = ->
    $("#invite-modal-title").text('Invite New Patient')  
    $("#invite-error").hide()
    $("#invitee-first-name").val("")
    $("#invitee-last-name").val("")
    $("#invitee-email").val("")
    $("#invitee-phone").val("")
    reset_form_errors("#invite-user-form")
    $("#invite-user-form").show()

    # for ie9 
    $("#invitee-first-name").placeholder()
    $("#invitee-last-name").placeholder()
    $("#invitee-email").placeholder()
    $("#invitee-phone").placeholder()
    # end for ie9

    $("#invite-user-success").hide()

  reset_enroll = ->
    $("#enroll-modal-title").text('Enroll New Patient')  
    $("#enroll-error").hide()
    $("#enroll-first-name").val("").placeholder()
    $("#enroll-last-name").val("").placeholder()
    $("#enroll-dob").val("").placeholder()
    $("#enroll-phone").val("").placeholder()
    $("#enroll-email").val("").placeholder()
    reset_form_errors("#enroll-user-form")
    $("#enroll-user-form").show()
    $("#enroll-user-success").hide()

  reset_form_errors = (form_container) ->
    $(form_container + " div").removeClass("error")
    $(form_container + " label").removeClass("error")

  submit_invite = (action, invitee) ->
    $.ajax action,
      type: 'POST'
      data:
        patient_first_name: invitee.first_name
        patient_last_name: invitee.last_name
        patient_email: invitee.email
        patient_phone: invitee.phone
      success: display_invite_success
      error: display_invite_error

  display_invite_error = (jqXHR, testStatus, errorThrown) ->
    errorMsg = jqXHR.responseText
    $errorField = $("#invite-error")
    unless jqXHR.status == 500
      $errorField.text(errorMsg)
    $errorField.show()

  display_enroll_error = (jqXHR, testStatus, errorThrown) ->
    errorMsg = jqXHR.responseText || "There was a problem enrolling the patient."
    $errorField = $("#enroll-error")
    unless jqXHR.status == 500
      $errorField.text(errorMsg)
    $errorField.show()

  submit_enroll = (action) ->
    enrollee =
      first_name: document.getElementById("enroll-first-name").value
      last_name: document.getElementById("enroll-last-name").value
      dob: document.getElementById("enroll-dob").value
      phone: document.getElementById("enroll-phone").value
      email: document.getElementById("enroll-email").value
    $.ajax action,
      type: 'POST'
      data:
        first_name: enrollee.first_name
        last_name: enrollee.last_name
        dob: enrollee.dob
        phone: enrollee.phone
        email: enrollee.email
      success: display_enroll_success
      error: display_enroll_error

  display_invite_success = (data, textStatus, jqXRH) ->
    $("#invite-error").hide()
    $("#invite-modal-title").text('Invitation Sent')
    $("#invite-user-form").hide()
    $("#email-invite").text($("#invitee-email").val())
    $("#firstname-invite").text($("#invitee-first-name").val())
    $("#invite-user-success").show()

  display_enroll_success = (data, textStatus, jqXRH) ->
    enrollee_name = $("#enroll-first-name").val() + ' ' + $("#enroll-last-name").val()
    $("#enroll-modal-title").text('Patient Info Saved')
    $("#enroll-user-form").hide()
    $("#name-enroll").text(enrollee_name)
    $("#enroll-user-success").show()

  $("#close-invite-modal").on "click", ->
    $('#invite-patient').foundation('reveal', 'close')

  $("#close-enroll-modal").on "click", ->
    $('#enroll-patient').foundation('reveal', 'close')
  
  $("a.dismiss-alert").on("ajax:success", (e, data, status, xhr) ->
    $("#alert-"+ this.dataset["alert"]).hide("slow")
  )

  $("a.dismiss-task").on("ajax:success", (e, data, status, xhr) ->
    $("#task-"+ this.dataset["task"]).hide("slow")
  )

  $("#enroll-dob").datepicker({changeYear:true, yearRange:"-140:+0"});

  if document.getElementById("intervention-alerts")
    setInterval (->
      window.location.reload(true)
      return
    ), 300000
  return

  
  