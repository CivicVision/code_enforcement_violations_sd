caseSource = {
  "description": "A simple bar chart with embedded data.",
  "data": {
    "url": "data/case_by_case_source.csv"
  },
  "mark":"bar",
  "encoding": {
    "y": {"field": "case_source", "type": "ordinal", "sort": {"op": "sum", "field": "cases"}, "axis": {"title": "Case Source"}},
    "x": {"field": "cases", "type": "quantitative", "axis": {"title": "# Cases"}}
  }
}
closingReasons = {
  "description": "A simple bar chart with embedded data.",
  "data": { "url": "data/closed_by_reason.csv" },
  "mark":"bar",
  "encoding": {
    "y": {"field": "close_reason", "type": "ordinal", "sort": {"op": "sum", "field": "count"}, "axis": {"title": "Close Reason"}},
    "x": {"field": "count", "type": "quantitative", "axis": {"title": "# Cases"}},
    "order": {"field": "open", "type": "ordinal", "sort": "descending"}
  }
}
workgroup= {
  "description": "A simple bar chart with embedded data.",
  "data": { "url": "data/case_by_workgroup.csv" },
  "mark":"bar",
  "encoding": {
		"y": {"field": "workgroup", "type": "ordinal", "sort": {"op": "sum", "field": "open"}, "axis": {"title": "Workgroup"}},
		"x": {"field": "open", "type": "quantitative", "axis": {"title": "# Cases"}}
  }
}
cases_closed_per_month = {
  "description": "A simple bar chart with embedded data.",
  "data": { "url": "data/code_violations_year_month_backlog_tidy.csv" },
  "mark":"line",
  "encoding": {
    "x": {"field": "year_month", "type": "ordinal", "scale": {"bandSize": 50, "padding": 0.5} },
    "y": { "aggregate": "median", "field": "cases", "type": "quantitative", "axis": {"title": "# Cases"}}
    "color": {"field": "case_type", "type": "nominal"}
  }
}
backlogPerWorkgroup = {
  "description": "A simple bar chart with embedded data.",
  "data": { "url": "data/code_violations_year_month_workgroup_backlog_tidy.csv" },
  "mark":"line",
  "encoding": {
    "column": {"field": "workgroup", "type": "nominal"},
    "x": {"field": "year_month", "type": "ordinal"},
    "y": { "field": "cases", "type": "quantitative", "axis": {"title": "# Cases"}}
    "color": {"field": "case_type", "type": "nominal"}
  }
}
embedSpec = 
  mode: 'vega-lite'
  spec: workgroup
  actions: false
vg.embed '#working-group', embedSpec, (error, result) ->
  # Callback receiving the View instance and parsed Vega spec
  # result.view is the View, which resides under the '#vis' element
  return
closingSpec = 
  mode: 'vega-lite'
  spec: closingReasons
  actions: false
vg.embed '#closing-reasons', closingSpec, (error, result) ->
  # Callback receiving the View instance and parsed Vega spec
  # result.view is the View, which resides under the '#vis' element
  return
sourceSpec = 
  mode: 'vega-lite'
  spec: caseSource
  actions: false
vg.embed '#case-sources', sourceSpec, (error, result) ->
  # Callback receiving the View instance and parsed Vega spec
  # result.view is the View, which resides under the '#vis' element
  return
per_month_Spec = 
  mode: 'vega-lite'
  spec: cases_closed_per_month
  actions: false
vg.embed '#case-per-month', per_month_Spec, (error, result) ->
  # Callback receiving the View instance and parsed Vega spec
  # result.view is the View, which resides under the '#vis' element
  return
backlogWorkgroupSpec= 
  mode: 'vega-lite'
  spec: backlogPerWorkgroup
  actions: false
vg.embed '#backlog-per-workgroup', backlogWorkgroupSpec, (error, result) ->
  # Callback receiving the View instance and parsed Vega spec
  # result.view is the View, which resides under the '#vis' element
  return
