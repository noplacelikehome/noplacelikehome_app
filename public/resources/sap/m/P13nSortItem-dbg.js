/*
 * ! SAP UI development toolkit for HTML5 (SAPUI5/OpenUI5)
 * (c) Copyright 2009-2015 SAP SE or an SAP affiliate company.
 * Licensed under the Apache License, Version 2.0 - see LICENSE.txt.
 */

// Provides control sap.m.P13nSortItem.
sap.ui.define([
	'jquery.sap.global', './library', 'sap/ui/core/Item'
], function(jQuery, library, Item) {
	"use strict";

	/**
	 * Constructor for a new P13nSortItem.
	 * 
	 * @param {string} [sId] id for the new control, generated automatically if no id is given
	 * @param {object} [mSettings] initial settings for the new control
	 * @class tbd
	 * @extends sap.ui.core.Item
	 * @version 1.26.6
	 * @constructor
	 * @public
	 * @alias sap.m.P13nSortItem
	 * @ui5-metamodel This control/element also will be described in the UI5 (legacy) designtime metamodel
	 */
	var P13nSortItem = Item.extend("sap.m.P13nSortItem", /** @lends sap.m.P13nSortItem.prototype */
	{
		metadata: {

			library: "sap.m",
			properties: {

				/**
				 * tbd
				 */
				operation: {
					type: "string",
					group: "Misc",
					defaultValue: null
				},

				/**
				 * tbd
				 */
				columnKey: {
					type: "string",
					group: "Misc",
					defaultValue: null
				}
			}
		}
	});

	return P13nSortItem;

}, /* bExport= */true);
