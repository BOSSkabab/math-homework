def get_date(text):
    parts = text.split('מ')
    if len(parts) > 1:
        return parts[0]
    else:
        return None


def get_title(entry):
    str = entry.split('עמ')[0]
    list = str.split('-')
    for i in range(len(list)):
        list[i] = list[i].strip()
    if len(list) == 2:
        return list[1]
    if len(list) == 3:
        return list[2]
    if len(list) == 4:
        return list[2] + '-' + list[3]


def get_pages(entry):
    list = entry.split('עמ')
    list.pop(0)
    for i in range(len(list)):
        list[i] = list[i].strip()
        list[i] = list[i].replace('׳', '')
    return list