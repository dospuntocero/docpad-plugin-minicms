
# Default validator for all fields
module.exports = (field, val) ->

    if field.optional and not val?
        return true

    # Image
    if field.type is 'file' and field.images
        expectedKeys = []
        for key of field.images
            expectedKeys.push key
        i = 0
        if typeof(val) isnt 'object' then return false
        if not val? then return false
        keys = []
        for k, v of val
            keys.push k
        if keys.length isnt expectedKeys.length then return false
        for k in expectedKeys
            if not (k in keys) then return false
        for k in keys
            if typeof(val[k].url) isnt 'string' then return false
            if typeof(val[k].width) isnt 'number' or val[k].width < 1 then return false
            if typeof(val[k].height) isnt 'number' or val[k].height < 1 then return false
        return true

    # Text
    else if field.type is 'text'
        return typeof(val) is 'string' and val.trim().length > 0

    # Textarea
    else if field.type is 'textarea'
        return typeof(val) is 'string' and val.trim().length > 0

    # Wysiwyg
    else if field.type is 'wysiwyg'
        return typeof(val) is 'string' and val.trim().length > 0

    # Markdown
    else if field.type is 'markdown'
        return typeof(val) is 'string' and val.trim().length > 0

    # Choice
    else if field.type is 'choice'
        return typeof(val) is 'string' and val.trim().length > 0

    # Date
    else if field.type is 'date'
        return typeof(val) is 'number' and Math.floor(val) is val

    # Tags
    else if field.type is 'tags'
        if not (val instanceof Array)
            return false
        for item in val
            if not typeof(item) is 'string'
                return false
        return true

    # Other, not handled, so not valid
    else
        return false
