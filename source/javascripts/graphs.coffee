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
    "y": {"field": "workgroup", "type": "ordinal", "sort": {"op": "sum", "field": "open", "order": "descending" }, "axis": {"title": "Workgroup"}},
    "x": {"field": "open", "type": "quantitative", "axis": {"title": "# Cases"}}
  }
}
cases_closed_per_month = {
  "description": "A simple bar chart with embedded data.",
  "data": {
    "url": "data/code_violations_year_month_backlog_tidy.csv",
    "format": {"type": "csv"},
    "transform": [
      {
        "type": "filter",
        "test": "datum.year_month == \"2015-12\""
      }
    ]
  },
  "mark":"line",
  "encoding": {
    "x": {"field": "year_month", "type": "ordinal", "scale": {"bandSize": 50, "padding": 0.5}, "axis": { "title": "Month" } },
    "y": { "aggregate": "median", "field": "cases", "type": "quantitative", "axis": {"title": "# Cases"}},
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
    "y": { "field": "cases", "type": "quantitative", "axis": {"title": "# Cases"}},
    "color": {"field": "case_type", "type": "nominal"}
  }
}
openCasesByInvestigatorBar = {
  "description": "A simple bar chart with embedded data.",
  "data": {
    "url": "data/code_violations_year_month_backlog_06_2016_tidy.csv",
    "format": {"type": "csv","parse": {"cases": "number"}},
  },
  "transform": {
    "filter": "(datum.year_month == \"2016-06\")",
    "calculate": [{"field": "case_types", "expr": "if(datum.case_type == \"backlog\", \"Open Cases\" , \"new cases this month\")"}]
  },
  "mark":"bar",
  "encoding": {
    "row": {"field": "investigator_name", "type": "ordinal", "sort": {"op": "sum", "field": "cases", "order": "descending"}, "axis": {"orient": "left", "title": "Investigator",  "axisWidth": 1, "offset": -8, "labelAngle": -1}, "scale": { "padding": 0}},
    "x": {"field": "cases", "aggregate": "sum", "type": "quantitative", "axis": {"title": "Cases", "orient": "bottom", "axisWidth": 1, "offset": -8}, "scale": { "padding": 0}},
    "y": {"field": "case_type", "type": "nominal", "axis": false, "scale": {"bandSize": 10}},
    "color": {"field": "case_types", "type": "nominal", "legend": { "title": "Cases"}}
  },
  "config":{"facet": {"cell": {"strokeWidth": 0}}}
}
openCasesLastActionBar= {
  "description": "A simple bar chart with embedded data.",
  "data": {
    "url": "data/code_violations_open_last_action.csv",
  },
  "transform": {
    "filter": "(datum.count > 100)",
  },
  "mark":"bar",
  "encoding": {
    "x": {"field": "count", "type": "quantitative", "axis": {"title": "Cases"}, "scale": { "bandSize": "fit"}},
    "y": {"field": "last_action", "type": "nominal", "axis": {"title": "Last Action", "labelMaxLength": 200}, "sort": { "op": "sum", "field": "count", "order": "descending"}}
  }
}
openCasesByInvestigator = {
  "description": "A simple bar chart with embedded data.",
  "data": {
    "url": "data/code_violations_year_month_investigator_backlog.csv",
    "format": {"type": "csv","parse": {"backlog": "number"}},
    "transform": [
      {
        "type": "filter",
        "test": "(datum.year_month == \"2016-06\")"
      }
    ]
  },
  "mark":"point",
  "encoding": {
    "color": {"field": "investigator_name", "type": "ordinal", "axis": {"title": "Investigator"}},
    "x": {"field": "backlog", "type": "quantitative", "axis": {"title": "# Cases"}},
    "y": {"field": "closing_rate", "type": "quantitative", "axis": {"title": "# Close Rate"}}
  }
}
backlogSlope = {
  "width": 1,
  "height": 1,
  "padding": "auto",
  "data": [
    {
      "name": "source",
      "url": "data/code_violations_year_month_backlog_tidy.csv",
      "format": {"type": "csv","parse": {"cases": "number", "year_month": "date:'%Y-%m'"}},
      "transform": [
        {"type": "formula", "field": "date", "expr": "year(datum.year_month)+\"-\"+(month(datum.year_month)+1)"},
        {
          "type": "filter",
          "test": "datum[\"cases\"] !== null && !isNaN(datum[\"cases\"])"
        },
        {
          "type": "filter",
          "test": "datum.date == \"2016-1\" || datum.date == \"2016-6\""
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
            "transform": [{"type": "facet","groupby": ["case_type"]}]
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
                  "stroke": {"scale": "color","field": "case_type"}
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
                  "fill": {"scale": "color", "field": "case_type"},
                  "size": {"value": 36}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-1\" && datum.case_type == \"backlog\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": -30},
                  "y": {"scale": "y", "field": "cases"},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "cases"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-1\" && datum.case_type == \"closed\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": -25},
                  "y": {"scale": "y", "field": "cases", "offset": 5},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "cases"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-1\" && datum.case_type == \"open\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": -25},
                  "y": {"scale": "y", "field": "cases", "offset": -5},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "cases"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\" && datum.case_type == \"open\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 35},
                  "y": {"scale": "y", "field": "cases", "offset": -5},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "case_type"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\" && datum.case_type == \"closed\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 35},
                  "y": {"scale": "y", "field": "cases", "offset": 5},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "case_type"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\" && datum.case_type == \"backlog\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 35},
                  "y": {"scale": "y", "field": "cases"},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "case_type"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\" && datum.case_type == \"open\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 5},
                  "y": {"scale": "y", "field": "cases", "offset": -5},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "cases"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\" && datum.case_type == \"closed\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 5},
                  "y": {"scale": "y", "field": "cases", "offset": 5},
                  "fill": {"scale": "color", "field": "case_type"},
                  "text": {"field": "cases"},
                  "baseline": {"value": "middle"}
                }
              }
            },
            {
              "type": "text",
              "from": {
                "transform": [{"type": "filter", "test": "datum.date == \"2016-6\" && datum.case_type == \"backlog\""}]
              },
              "properties": {
                "update": {
                  "x": {"scale": "x", "field": "year_month", "offset": 5},
                  "y": {"scale": "y", "field": "cases"},
                  "fill": {"scale": "color", "field": "case_type"},
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
            "field": "case_type",
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
        }
      ],
      "legends": [
      ]
    }
  ]
}


casesPerMonth2016 = {
  "padding": "auto",
  "data": [
    {
      "name": "source",
      "url": "data/code_violations_year_month_backlog_tidy.csv",
      "format": {"type": "csv","parse": {"cases": "number", "YEAR_CLOSED": "number"}},
      "transform": [
        {
          "type": "filter",
          "test": "datum[\"cases\"] !== null && !isNaN(datum[\"cases\"])"
        },
        {
          "type": "filter",
          "test": "(datum.YEAR_CLOSED > 2015)"
        }
      ]
    },
    {
      "name": "summary",
      "source": "source",
      "transform": [
        {
          "type": "aggregate",
          "groupby": ["year_month","case_type"],
          "summarize": {"cases": ["median"]}
        }
      ]
    },
    {
      "name": "layout",
      "source": "summary",
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
            "data": "summary",
            "transform": [{"type": "facet","groupby": ["case_type"]}]
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
                  "y": {"scale": "y","field": "median_cases"},
                  "strokeWidth": {"value": 2},
                  "stroke": {"scale": "color","field": "case_type"}
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
            "data": "summary",
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
          "domain": {"data": "summary","field": "median_cases"},
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
            "data": "summary",
            "field": "case_type",
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
          "ticks": 5,
          "title": "Month",
          "properties": {
            "labels": {
              "text": {
                "template": "{{ datum[\"data\"] | truncate:25 }}"
              },
              "angle": {"value": 270},
              "align": {"value": "right"},
              "baseline": {"value": "middle"}
            }
          }
        },
        {
          "type": "y",
          "scale": "y",
          "format": "s",
          "grid": true,
          "layer": "back",
          "title": "# Cases"
        }
      ],
      "legends": [
        {
          "stroke": "color",
          "title": "case_type",
          "properties": {
            "symbols": {
              "strokeWidth": {"value": 2},
              "shape": {"value": "circle"}
            }
          }
        }
      ]
    }
  ]
}

getContainerWidth = (container_id) ->
  container = document.querySelector(container_id)
  container.offsetWidth

window.onload = () ->
  legendSize = 300
  workgroup.width = getContainerWidth('#working-group')
  embedSpec =
    mode: 'vega-lite'
    spec: workgroup
    actions: false
  vg.embed '#working-group', embedSpec

  casesPerMonth2016.width = getContainerWidth('#case-per-month') 
  per_month_Spec =
    mode: 'vega'
    spec: casesPerMonth2016
    actions: false
  vg.embed '#case-per-month', per_month_Spec

  openCasesByInvestigatorBar.config.facet.cell.width = getContainerWidth('#backlog-investigator') - legendSize
  openCasesSpec =
    mode: 'vega-lite'
    spec: openCasesByInvestigatorBar
    actions: false
  vg.embed '#backlog-investigator', openCasesSpec

  openCasesLastActionBar.width = getContainerWidth('#last-action') - legendSize
  lastActionSpec =
    mode: 'vega-lite'
    spec: openCasesLastActionBar
    actions: false
  vg.embed '#last-action', lastActionSpec

  backlogSlope.width = getContainerWidth('#backlog-slope')
  backlogSlopeSpec =
    mode: 'vega'
    spec: backlogSlope
    actions: false
  vg.embed '#backlog-slope', backlogSlopeSpec
