'use strict';
var Components = Components || {};
Components.Deal = Components.Deal || React.createClass({
        displayName: "Components.Deals",
        propTypes: {
            name: React.PropTypes.string,
            stage_name: React.PropTypes.string,
            summary: React.PropTypes.string,
            amount: React.PropTypes.number
        },

        render: function () {
            return (<div className="deal-entity">
                <dl class="dl-horizontal">
                    <dt className="deal-label"> Name</dt>
                    <dd className="deal-name"> {this.props.name} </dd>
                    <dt className="deal-label"> Stage</dt>
                    <dd className="deal-stage"> {this.props.stage_name} </dd>
                    <dt className="deal-label"> Summary</dt>
                    <dd className="deal-summary"> {this.props.summary} </dd>
                    <dt className="deal-label"> Amount</dt>
                    <dd className="deal-phone"> {this.props.amount}</dd>
                </dl>
            </div>)
        }
    });
Components.DealsList = Components.DealsList || React.createClass({
        displayName: "Components.DealsList",
        propTypes: {
            apiResults: React.PropTypes.array
        },

        render: function () {
            return (<ul className="list-unstyled">
                {this.props.apiResults.map(function (apiResult) {
                    return <li key={apiResult.id}>
                        <Components.Deal name={apiResult.name} stage_name={apiResult.stage_name}
                                            summary={apiResult.summary} amount={apiResult.amount} />
                    </li>
                })}
            </ul>)
        }

    });

Components.DealsForm = Components.DealsForm || React.createClass({
        displayName: "Components.DealsForm",
        propTypes: {
          onDealSubmit: React.PropTypes.func
        },

        getInitialState: function() {
          return {
              stage: 1,
              name: '',
              summary: '',
              amount: 0.0
          }
        },
        handleNameChange: function(e) {
          this.setState({name: e.target.value})
        },
        handleStageChange: function(e) {
            this.setState({stage: e.target.value})
        },
        handleAmountChange: function(e) {
            this.setState({amount: e.target.value})
        },
        handleSummaryChange: function(e){
            this.setState({summary: e.target.value})
        },
        handleSubmit: function(e){
            e.preventDefault();
            var name = this.state.name.trim();
            var stage = this.state.stage;
            var summary = this.state.summary.trim();
            var amount = this.state.amount;
            if(!name){
                return;
            }

            this.props.onDealSubmit({
                    name: name,
                    stage: stage,
                    summary: summary,
                    amount: amount
                });
            this.setState(this.getInitialState());
        },
        render: function () {
            return (
                <form className="new_deal" id="new_deal" onSubmit={this.handleSubmit}>
                    <div className="form-group">
                        <label for="deal_name">Name</label>
                        <input className="form-control"
                               type="text"
                               id="deal_name"
                               value={this.state.name}
                               onChange={this.handleNameChange}
                        />
                    </div>
                    <div className="form-group">
                        <select class="form-control" onChange={this.handleStageChange}>
                            <option value="1">Lost</option>
                            <option value="2">Qualified</option>
                            <option value="3">In progress</option>
                            <option value="4">Won</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="deal_summary">Summary</label>
                        <input className="form-control"
                               type="text"
                               id="deal_summary"
                               value={this.state.summary}
                               onChange={this.handleSummaryChange}
                        />
                    </div>
                    <div class="form-group">
                        <label for="deal_amount">Amount</label>
                        <input className="form-control"
                               type="number"
                               step="0.01"
                               id="deal_amount"
                               value={this.state.amount}
                               onChange={this.handleAmountChange}
                        />
                    </div>
                    <button type="submit" class="btn btn-default">Create</button>
                </form>
            )
        }
    });

Components.DealsBox = Components.DealsBox || React.createClass({
        displayName: "Components.DealsBox",
        propTypes: {
            source: React.PropTypes.string,
            target: React.PropTypes.string
        },
        getInitialState: function () {
            return {loaded: false, apiResults: []};
        },

        componentDidMount: function () {
            this.callApi()
        },

        componentWillUnmount: function () {
            this.serverRequest.abort();
        },

        callApi: function () {
            var self = this;
            this.serverRequest = $.get(this.props.source, function (results) {
                var parsedResults = results.deals.map(function (result) {
                    return self.parseResult(result);
                });
                self.setState({apiResults: parsedResults, loaded: true})
            }.bind(this));
        },


        parseResult: function (result) {
            var stage = result.stage || {name: ''};
            return {
                name: result.name || '',
                stage_name: stage.name,
                summary: result.summary || '',
                amount: result.amount || 0.0
            }
        },

        handleDealSubmit: function(deal){
            var self = this;
            $.post(this.props.target, deal, function(results){
                self.callApi()
            });
        },

        render: function () {
            return (
                <div className="row">
                    <div className="col-md-8">
                        <Components.DealsList apiResults={this.state.apiResults}/>
                    </div>

                    <div className="col-md-4 scollableForm">
                        <Components.DealsForm onDealSubmit={this.handleDealSubmit} />
                    </div>
                </div>
            )
        }
    });
