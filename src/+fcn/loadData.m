function raw_data = loadData()

raw_data = webread(['https://docs.google.com/spreadsheets/d/' ...
    '1p6sgUQWW_lL8lO7_7sFgebqV4PjqcMbbY7v6eexUmn0/gviz/tq?' ...
    'tqx=out:csv&sheet=raw-data']);

end