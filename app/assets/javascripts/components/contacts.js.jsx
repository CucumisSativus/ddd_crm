'use strict';
var Components = Components || {};
Components.Contact = Components.Contact || React.createClass({
        displayName: "Components.Contacts",
        propTypes: {
            name: React.PropTypes.string,
            email: React.PropTypes.string,
            phone: React.PropTypes.string
        },

        render: function () {
            return (<div className="contact-entity">
                <dl class="dl-horizontal">
                    <dt className="contact-label"> Name</dt>
                    <dd className="contact-name"> {this.props.name} </dd>
                    <dt className="contact-label"> Email</dt>
                    <dd className="contact-email"> {this.props.email} </dd>
                    <dt className="contact-label"> Phone</dt>
                    <dd className="contact-phone"> {this.props.phone}</dd>
                </dl>
            </div>)
        }
    });
Components.ContactsList = Components.ContactsList || React.createClass({
        displayName: "Components.ContactsList",
        propTypes: {
            apiResults: React.PropTypes.array
        },

        render: function () {
            return (<ul className="list-unstyled">
                {this.props.apiResults.map(function (apiResult) {
                    return <li key={apiResult.id}>
                        <Components.Contact name={apiResult.name} email={apiResult.email}
                                            phone={apiResult.phone}/>
                    </li>
                })}
            </ul>)
        }

    });

Components.ContactsForm = Components.ContactsForm || React.createClass({
        displayName: "Components.ContactsForm",
        propTypes: {
          onContactSubmit: React.PropTypes.func
        },

        getInitialState: function() {
          return {
              name: '',
              email: '',
              phone: ''
          }
        },
        handleNameChange: function(e) {
          this.setState({name: e.target.value})
        },
        handleEmailChange: function(e) {
            this.setState({email: e.target.value})
        },
        handlePhoneChange: function(e) {
            this.setState({phone: e.target.value})
        },
        handleSubmit: function(e){
            e.preventDefault();
            var name = this.state.name.trim();
            var email = this.state.email.trim();
            var phone = this.state.phone.trim();
            if(!name){
                return;
            }

            this.props.onContactSubmit({name: name, email: email, phone: phone});
            this.setState(this.getInitialState());
        },
        render: function () {
            return (
                <form className="new_contact" id="new_contact" onSubmit={this.handleSubmit}>
                    <div className="form-group">
                        <label for="contact_name">Name</label>
                        <input className="form-control"
                               type="text"
                               id="contact_name"
                               value={this.state.name}
                               onChange={this.handleNameChange}
                        />
                    </div>
                    <div className="form-group">
                        <label for="contact_email">Email</label>
                        <input className="form-control"
                               type="text"
                               id="contact_email"
                               value={this.state.email}
                               onChange={this.handleEmailChange}
                        />
                    </div>
                    <div className="form-group">
                        <label for="contact_phone">Phone</label>
                        <input className="form-control"
                               type="text"
                               id="contact_phone"
                               value={this.state.phone}
                               onChange={this.handlePhoneChange}
                        />
                    </div>

                    <button type="submit" className="btn btn-default">Create</button>
                </form>
            )
        }
    });

Components.ContactsBox = Components.ContactsBox || React.createClass({
        displayName: "Components.ContactsBox",
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
                var parsedResults = results.contacts.map(function (result) {
                    return self.parseResult(result);
                });
                self.setState({apiResults: parsedResults, loaded: true})
            }.bind(this));
        },


        parseResult: function (result) {
            return {
                id: result.id,
                name: result.name,
                email: result.email,
                phone: result.phone
            }
        },

        handleContactSubmit: function(contact){
            var self = this;
            $.post(this.props.target, contact, function(results){
                self.callApi()
            });
        },

        render: function () {
            return (
                <div className="row">
                    <div className="col-md-8">
                        <Components.ContactsList apiResults={this.state.apiResults}/>
                    </div>

                    <div className="col-md-4 scollableForm">
                        <Components.ContactsForm onContactSubmit={this.handleContactSubmit} />
                    </div>
                </div>
            )
        }
    });
