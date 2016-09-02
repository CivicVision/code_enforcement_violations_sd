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
backlogSlope = {
  "width": 1,
  "height": 1,
  "padding": "auto",
  "data": [
    {
      "name": "source",
      "url": "data/code_violations_year_month_workgroup_backlog_tidy.csv",
      "format": {"type": "csv","parse": {"cases": "number", "year_month": "date:'%Y-%m'"}},
      "transform": [
        {"type": "formula", "field": "date", "expr": "year(datum.year_month)+\"-\"+(month(datum.year_month)+1)"},
        {
          "type": "filter",
          "test": "datum[\"cases\"] !== null && !isNaN(datum[\"cases\"])"
        },
        {
          "type": "filter",
          "test": "(datum.date == \"2016-1\" || datum.date == \"2016-6\") && datum.case_type == \"backlog\""
        }
      ]
    },
    {
      "name": "layout",
      "source": "source",
      "transform": [
        {
          "type": "aggregate",
          "summarize": [{"field": "year_month","ops": ["distinct"]}]
        },
        {
          "type": "formula",
          "field": "width",
          "expr": "(datum[\"distinct_year_month\"] + 1) * 50"
        },
        {"type": "formula","field": "height","expr": "200"}
      ]
    }
  ],
  "marks": [
    {
      "name": "root",
      "type": "group",
      "description": "A simple bar chart with embedded data.",
      "from": {"data": "layout"},
      "properties": {
        "update": {
          "width": {"field": "width"},
          "height": {"field": "height"}
        }
      },
      "marks": [
        {
          "name": "pathgroup",
          "type": "group",
          "from": {
            "data": "source",
            "transform": [{"type": "facet","groupby": ["workgroup"]}]
          },
          "properties": {
            "update": {
              "width": {"field": {"group": "width"}},
              "height": {"field": {"group": "height"}}
            }
          },
          "marks": [
            {
              "name": "marks",
              "type": "line",
              "from": {
                "transform": [{"type": "sort","by": "-year_month"}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x","field": "year_month"},
                  "y": {"scale": "y","field": "cases"},
                  "strokeWidth": {"value": 2},
                  "stroke": {"scale": "color","field": "workgroup"}
                }
              }
            },
            {
              "name": "marks",
              "type": "symbol",
              "from": {
                "transform": [{"type": "sort","by": "-year_month"}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x","field": "year_month"},
                  "y": {"scale": "y","field": "cases"},
                  "fill": {"scale": "color", "field": "workgroup"},
                  "size": {"value": 36}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-1\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": -25},
                  "y": {"scale": "y", "field": "cases"},
                  "fill": {"scale": "color", "field": "workgroup"},
                  "text": {"field": "cases"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 35},
                  "y": {"scale": "y", "field": "cases"},
                  "fill": {"scale": "color", "field": "workgroup"},
                  "text": {"field": "workgroup"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 35},
                  "y": {"scale": "y", "field": "cases"},
                  "fill": {"scale": "color", "field": "workgroup"},
                  "text": {"field": "workgroup"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 5},
                  "y": {"scale": "y", "field": "cases"},
                  "fill": {"scale": "color", "field": "workgroup"},
                  "text": {"field": "cases"},
                  "baseline": {"value": "middle"}
                }
              }
            }
          ]
        }
      ],
      "scales": [
        {
          "name": "x",
          "type": "ordinal",
          "domain": {
            "data": "source",
            "field": "year_month",
            "sort": true
          },
          "bandSize": 50,
          "round": true,
          "points": true,
          "padding": 1
        },
        {
          "name": "y",
          "type": "linear",
          "domain": {"data": "source","field": "cases"},
          "rangeMin": 200,
          "rangeMax": 0,
          "round": true,
          "nice": true,
          "zero": true
        },
        {
          "name": "color",
          "type": "ordinal",
          "domain": {
            "data": "source",
            "field": "workgroup",
            "sort": true
          },
          "range": "category10"
        }
      ],
      "axes": [
        {
          "type": "x",
          "scale": "x",
          "grid": false,
          "ticks": 2,
          "title": "Date",
          "properties": {
            "labels": {
              "text": {
                "template": "{{ datum[\"data\"] | time: '%b %Y'}}"
              },
              "angle": {"value": 0}
            }
          }
        },
      ],
      "legends": [
      ]
    }
  ]
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
backlogSlopeSpec = 
  mode: 'vega-lite'
  spec: backlogSlope
  actions: false
vg.embed '#backlog-slope', backlogSlopeSpec, (error, result) ->
  # Callback receiving the View instance and parsed Vega spec
  # result.view is the View, which resides under the '#vis' element
  return
