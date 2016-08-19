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
