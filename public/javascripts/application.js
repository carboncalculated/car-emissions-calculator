if (typeof SimpleQuestion == "undefined"){
	var SimpleQuestion = {};
};

// Keep this a too simple for some; some refactor can be done here; by all means 
// be me guest; You may also want to add in auto loading for editing and failed
// computations so the drop down values are kept or got 
SimpleQuestion.DropDown = new Class({
	Implements: [Events],
	Binds : ["_fire"],

	initialize: function(element, elementName, targetElement, targetName, clearingElements, trackingElements){
		this.element = document.id(element);
		this.targetElement = document.id(targetElement);
		this.targetName = targetName;
		this.elementName = elementName;
		this.trackingElements = trackingElements || [];
		this.clearingElements = clearingElements || [];
		this.attach();
	},
	
	attach : function(){
		this.element.addEvent("change", this._fire);
	},
	
	_fire : function(event){
		event.stop();
		this.clearClearingElements();
		this.loadingTarget();
		this.getOptions();
	},
	
	clearClearingElements : function(){
		this.clearingElements.each(function(el){
			document.id(el).getElements("option").each(function(option){
				if ((option.value)){
					option.dispose();
				}
			})
		})
	},
	
	buildOptions : function(responseJSON){
		responseJSON["options"].each(function(data){
			var option = new Element("option", {"value" : data.value, "html" : data.name});
			option.inject(this.targetElement);
		}, this);
	},
	
	loadingTarget: function(){
		this.targetElement.getParent().addClass("loading");
	},

	finishedTarget: function(){
		this.targetElement.getParent().removeClass("loading");
	},
	
	parameters: function(){
		var trackedValues = this.trackingElements.map(function(el){
			return "[car_calculator][relatable_category_ids][]="+document.id(el).value;
		});
		return ["[car_calculator]["+this.elementName+"]="+this.element.value, trackedValues].flatten().join("&");
	},
	
	getOptions: function(){
		var request = new Request.JSON({
			data: this.parameters(),
			url: "/car_calculators/get_"+this.targetName,
			onComplete: function(){
					this.finishedTarget();
				}.bind(this),
			onSuccess : function(responseJSON){
				this.buildOptions(responseJSON);
			}.bind(this)
		}).send();
	}
})

window.addEvent('domready', function() {	
	if($$('.tooltip')[0]){
		$$('.tooltip').each(function(el){
			el.store('tip:text', el.getElement('.description').get('html'));
		}); 
		var toolTips = new Tips($$('.tooltip'),{
			showDelay: 0,
			hideDelay: 0,
			fixed: true,
			onShow: function(toolTipElement){
				toolTipElement.fade(1);
			},
			onHide: function(toolTipElement){
				toolTipElement.fade(0);
			}
		});
	}
	
	
	if (document.id("question")){
		
		var manufactorDropDown = new SimpleQuestion.DropDown(
				"car_calculator_manufacture",
				"manufacture",
				"car_calculator_fuel_type",
				"fuel_types",
				["car_calculator_fuel_type", "car_calculator_model", "car_calculator_car"]
			)
			
		var fuelTypeDropDown = new SimpleQuestion.DropDown(
				"car_calculator_fuel_type",
				"fuel_type",
				"car_calculator_model",
				"models",
				["car_calculator_model", "car_calculator_car"],
				["car_calculator_manufacture"]
			)
			
			var modelDropDown = new SimpleQuestion.DropDown(
					"car_calculator_model",
					"model",
					"car_calculator_car",
					"cars",
					["car_calculator_car"],
					["car_calculator_manufacture", "car_calculator_fuel_type"]
				)
	}
});
