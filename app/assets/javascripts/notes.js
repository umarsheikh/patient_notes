$(function() {
  $('#description').on('input', () => {
    let description = $('#description').val()
    let noteId = $('#id').val()
    submitData(description, noteId)
  })

  const submitData = async (description, noteId = null) => {
    let response = await fetch(
      noteId ? `/notes/${noteId}`: '/notes', {
      method: noteId ? "PUT" : "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({note: {
        description,
        id: noteId
      }})
    })
    response = await response.json()
    if(!noteId)
      setId(response.noteId)
  }

  const setId = id => {
    $('#id').val(id)
  }
})
