prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.04.04'
,p_release=>'18.1.0.00.45'
,p_default_workspace_id=>1662011781335193
,p_default_application_id=>112
,p_default_owner=>'MDB_SCHEMA'
);
end;
/
prompt --application/shared_components/plugins/item_type/mesquitarod_multirow_item
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(52089089196597213)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'MESQUITAROD.MULTIROW.ITEM'
,p_display_name=>'APEX MultiRow Item Plugin'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_javascript_file_urls=>'#PLUGIN_FILES#js/apexMultiRow-min.js'
,p_css_file_urls=>'#PLUGIN_FILES#css/apexMultiRow-min.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE Render_MultiRow_Item (',
'    p_item     IN apex_plugin.t_page_item,',
'    p_plugin   IN apex_plugin.t_plugin,',
'    p_param    IN apex_plugin.t_item_render_param,',
'    p_result   IN OUT NOCOPY apex_plugin.t_item_render_result',
')',
' IS',
'  lb_read_only           p_param.is_readonly%type := p_param.is_readonly;',
'  lv_read_only           varchar2(100);',
'  lb_is_printer_friendly p_param.is_printer_friendly%type := p_param.is_printer_friendly;',
'  ln_item_max_length     p_item.element_max_length%type := p_item.element_max_length;',
'  ln_item_size           p_item.element_width%type := p_item.element_width;',
'  lv_item_name           varchar2(1000) := apex_plugin.get_input_name_for_page_item(false);',
'  lv_format_mask         p_item.format_mask%type := p_item.format_mask;',
'  lv_item_css            varchar2(1000);',
'  lv_item_placeholder    p_item.placeholder%type := p_item.placeholder;',
'  lv_js_code             varchar2(4000);',
'  ln_limit               p_item.attribute_01%type:= p_item.attribute_01;',
'  lv_limit_message       p_item.attribute_02%type:= p_item.attribute_02;',
'  lv_add_icon            p_item.attribute_03%type:= p_item.attribute_03;',
'  lv_remove_icon         p_item.attribute_04%type:= p_item.attribute_04;',
' Begin',
' ',
'  IF lb_read_only',
'  THEN',
'     lv_item_css := ''display_only apex-item-display-only multiRow-displayOnly'';',
'     lv_read_only := ''true'';',
'  ELSE',
'     lv_item_css := ''text_field apex-item-text'';',
'     lv_read_only := ''false'';',
'  END IF;',
' ',
'    IF apex_application.g_debug ',
'    THEN',
'      apex_plugin_util.debug_page_item (p_plugin                => p_plugin,',
'                                        p_page_item             => p_item,',
'                                        p_value                 => p_param.value,',
'                                        p_is_readonly           => lb_read_only,',
'                                        p_is_printer_friendly   => lb_is_printer_friendly);',
'    END IF;',
'    ',
'    ',
'sys.htp.prn(''<textarea type="text" id="''||lv_item_name||''" name="''||lv_item_name||''" class="text_field apex-item-text" value="" size="" maxlength="">''||sys.htf.escape_sc(p_param.value)||''</textarea>'');',
'',
'lv_js_code := ''$("#''||lv_item_name||''").apexMultiRow({itemPlaceholder: "''||lv_item_placeholder||''",',
'                                                      itemSize: "''||ln_item_size||''",',
'                                                      itemCss: "''||lv_item_css||''",',
'                                                      itemMaxLength: "''||ln_item_max_length||''",',
'                                                      readOnly: ''||lv_read_only||'',',
'                                                      limit: "''||ln_limit||''",',
'                                                      limitMessage: "''||lv_limit_message||''",',
'                                                      addItemIcon: "''||lv_add_icon||''",',
'                                                      removeItemIcon: "''||lv_remove_icon||''"});'';                                                    ',
'apex_javascript.add_onload_code (lv_js_code);',
'    ',
' End Render_MultiRow_Item;'))
,p_api_version=>2
,p_render_function=>'Render_MultiRow_Item'
,p_standard_attributes=>'VISIBLE:READONLY:SOURCE:ELEMENT:WIDTH:PLACEHOLDER'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'  This plugin create a multi row APEX item.',
'</p>',
'<p>',
'  Author: <code>Rodrigo Mesquita</code><br/>',
'  E-mail: <code>rodrigomesquita.ti@gmail.com</code><br/>',
'  Twitter: <code>@mesquitarod</code><br/>',
'  Plugin home page: <code>https://github.com/rodrigomesquitaorclapex/APEX-MultiRow-Item-Plugin</code>',
'  License: Licensed under the MIT (LICENSE.txt) license.',
'</p>'))
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/rodrigomesquitaorclapex/APEX-MultiRow-Item-Plugin'
,p_files_version=>4
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(52090489502620862)
,p_plugin_id=>wwv_flow_api.id(52089089196597213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Limit'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'3'
,p_max_length=>2
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Enter the limit number of items',
'',
'<p><strong>Default</strong></p>',
'<ul>',
'<li>3</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(52090711603630397)
,p_plugin_id=>wwv_flow_api.id(52089089196597213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Limit Reached Message'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'Limit of items reached'
,p_max_length=>300
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Enter the limit reached warning message',
'',
'<p><strong>Default</strong></p>',
'<ul>',
'<li>Limit of items reached</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(52091049518635530)
,p_plugin_id=>wwv_flow_api.id(52089089196597213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Add Item Icon'
,p_attribute_type=>'ICON'
,p_is_required=>true
,p_default_value=>'fa-plus-square-o'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Enter the icon name</p>',
'<p><strong>Default</strong></p>',
'<ul>',
'<li>',
'<div>',
'<div>fa-plus-square-o</div>',
'</div>',
'</li>',
'</ul>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(52091380735641048)
,p_plugin_id=>wwv_flow_api.id(52089089196597213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Remove Item Icon'
,p_attribute_type=>'ICON'
,p_is_required=>true
,p_default_value=>'fa-minus-square-o'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>Enter the icon name</p>',
'<p><strong>Default</strong></p>',
'<ul>',
'<li>',
'<div>',
'<div>fa-minus-square-o</div>',
'</div>',
'</li>',
'</ul>'))
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E6D756C7469526F772D646973706C61794F6E6C797B706F696E7465722D6576656E74733A6E6F6E653B626F726465722D7374796C653A6E6F6E6521696D706F7274616E747D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(52090102967609673)
,p_plugin_id=>wwv_flow_api.id(52089089196597213)
,p_file_name=>'css/apexMultiRow-min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '76617220726561644F6E6C792C617065784974656D2C64656661756C74733D7B636C656172496E707574733A312C736570617261746F723A223A222C696E707574536570617261746F723A227C7C222C6F6E456C656D656E744164643A6E756C6C2C6F6E';
wwv_flow_api.g_varchar2_table(2) := '456C656D656E7452656D6F76653A6E756C6C7D3B66756E6374696F6E20506C7567696E28652C74297B746869732E6F7074696F6E733D64656661756C74732C746869732E637573746F6D3D742C726561644F6E6C793D742E726561644F6E6C792C617065';
wwv_flow_api.g_varchar2_table(3) := '784974656D3D242865292C746869732E656C656D656E743D242865292C746869732E656C656D656E7449643D746869732E656C656D656E742E617474722822696422292C746869732E656C656D656E74496E7075743D2428223C696E7075743E22292E61';
wwv_flow_api.g_varchar2_table(4) := '747472287B6E616D653A746869732E656C656D656E7449642B22496E707574222C69643A746869732E656C656D656E7449642B22496E707574222C747970653A2274657874222C636C6173733A742E6974656D4373732C706C616365686F6C6465723A74';
wwv_flow_api.g_varchar2_table(5) := '2E6974656D506C616365686F6C6465722C73697A653A742E6974656D53697A652C6D61786C656E6774683A742E6974656D4D61784C656E6774687D292C746869732E6164644C696E6B3D2428223C613E22292E616464436C617373282261646422292E63';
wwv_flow_api.g_varchar2_table(6) := '73732822637572736F72222C22706F696E74657222292E68746D6C28273C6920207374796C653D22746F703A202D3470783B2220636C6173733D2266612066612D6C6720272B742E6164644974656D49636F6E2B27223E3C2F693E3C7370616E203E203C';
wwv_flow_api.g_varchar2_table(7) := '2F7370616E3E27292C746869732E72656D6F76654C696E6B3D2428223C613E3C2F693E22292E616464436C617373282272656D6F766522292E6373732822637572736F72222C22706F696E74657222292E68746D6C28273C69207374796C653D22746F70';
wwv_flow_api.g_varchar2_table(8) := '3A202D3470783B6C6566743A202D3970783B2220636C6173733D2266612066612D6C6720272B742E72656D6F76654974656D49636F6E2B27223E3C2F693E3C7370616E203E3C2F7370616E3E27292C746869732E656C656D656E74496E707574733D6E75';
wwv_flow_api.g_varchar2_table(9) := '6C6C2C746869732E656C656D656E74436F756E743D302C746869732E657363536570617261746F723D746869732E6F7074696F6E732E736570617261746F722E7265706C616365282F5B5C2D5C5B5C5D5C2F7B7D28292A2B3F2E5C5C5E247C5D2F672C22';
wwv_flow_api.g_varchar2_table(10) := '5C5C242622292C746869732E657363496E707574536570617261746F723D746869732E6F7074696F6E732E696E707574536570617261746F722E7265706C616365282F5B5C2D5C5B5C5D5C2F7B7D28292A2B3F2E5C5C5E247C5D2F672C225C5C24262229';
wwv_flow_api.g_varchar2_table(11) := '2C746869732E7472696D45783D6E65772052656745787028225E28222B746869732E657363536570617261746F722B22292B7C28222B746869732E657363536570617261746F722B22292B24222C22676D22292C746869732E7472696D4578496E707574';
wwv_flow_api.g_varchar2_table(12) := '3D6E65772052656745787028225E28222B746869732E657363496E707574536570617261746F722B22292B7C28222B746869732E657363496E707574536570617261746F722B22292B24222C22676D22292C746869732E696E697428297D506C7567696E';
wwv_flow_api.g_varchar2_table(13) := '2E70726F746F747970653D7B696E69743A66756E6374696F6E28297B72657475726E20746869732E656C656D656E742E6C656E677468262628746869732E656C656D656E74496E707574733D746869732E66696C6C456C656D656E747356616C75657328';
wwv_flow_api.g_varchar2_table(14) := '746869732E656C656D656E74292C746869732E656C656D656E742E6869646528292E6265666F726528746869732E656C656D656E74496E7075747329292C746869737D2C636C656172496E707574733A66756E6374696F6E2865297B2428223A696E7075';
wwv_flow_api.g_varchar2_table(15) := '74222C65292E656163682866756E6374696F6E28297B242874686973292E76616C282222297D292C746869732E73617665456C656D656E747356616C75657328297D2C637265617465456C656D656E743A66756E6374696F6E28652C742C6E297B766172';
wwv_flow_api.g_varchar2_table(16) := '20693D746869732C733D652E636C6F6E65282131292C613D2428223C6469763E22292E616464436C6173732822696E7075745772617070657222292E6869646528292E617070656E642873293B2428225B69645D222C61292E656163682866756E637469';
wwv_flow_api.g_varchar2_table(17) := '6F6E28297B242874686973292E6174747228226964222C242874686973292E617474722822696422292B74297D292C2428225B69645D222C61292E656163682866756E6374696F6E28297B242874686973292E6174747228226964222C24287468697329';
wwv_flow_api.g_varchar2_table(18) := '2E6174747228226E616D6522292B74297D292C2428222E6E756D626572222C73292E7465787428742B31292C692E636C656172496E707574732861293B76617220723D6E2E73706C697428692E6F7074696F6E732E696E707574536570617261746F7229';
wwv_flow_api.g_varchar2_table(19) := '2C703D2428223A696E707574222C61293B696628722E6C656E67746829666F7228766172206C3D303B6C3C722E6C656E6774683B6C2B2B292428705B6C5D292E76616C28725B6C5D293B69662821726561644F6E6C7929766172206F3D692E6164644C69';
wwv_flow_api.g_varchar2_table(20) := '6E6B2E636C6F6E65282131292E636C69636B2866756E6374696F6E2865297B696628652E70726576656E7444656661756C7428292C692E656C656D656E74436F756E743C692E637573746F6D2E6C696D6974297B76617220743D692E637265617465456C';
wwv_flow_api.g_varchar2_table(21) := '656D656E7428692E656C656D656E74496E7075742C692E656C656D656E74436F756E742C2222292C6E3D242874686973292E706172656E747328222E696E7075745772617070657222292E696E64657828293B2428222E6E756D626572222C74292E7465';
wwv_flow_api.g_varchar2_table(22) := '7874286E2B32292C242874686973292E706172656E747328222E696E7075745772617070657222292E61667465722874292C242874686973292E706172656E747328222E696E7075745772617070657222292E6E657874416C6C28222E696E7075745772';
wwv_flow_api.g_varchar2_table(23) := '617070657222292E656163682866756E6374696F6E2865297B242874686973292E66696E6428222E6E756D62657222292E74657874286E2B652B32297D292C742E73686F7728302C66756E6374696F6E28297B242874686973292E72656D6F7665417474';
wwv_flow_api.g_varchar2_table(24) := '7228227374796C6522297D292C692E656C656D656E74436F756E742B2B2C692E616464456C656D656E744576656E74732874292C692E73617665456C656D656E747356616C75657328292C617065782E6A517565727928617065784974656D292E747269';
wwv_flow_api.g_varchar2_table(25) := '6767657228226368616E676522297D656C736520617065782E6D6573736167652E636C6561724572726F727328292C617065782E6D6573736167652E73686F774572726F7273285B7B747970653A226572726F72222C6C6F636174696F6E3A2270616765';
wwv_flow_api.g_varchar2_table(26) := '222C6D6573736167653A692E637573746F6D2E6C696D69744D6573736167652C756E736166653A21317D5D297D292C753D692E72656D6F76654C696E6B2E636C6F6E65282131292E636C69636B2866756E6374696F6E2874297B696628742E7072657665';
wwv_flow_api.g_varchar2_table(27) := '6E7444656661756C7428292C2428222E696E70757457726170706572222C692E656C656D656E74496E70757473292E6C656E6774683E31297B766172206E3D242874686973292E706172656E747328222E696E7075745772617070657222292E696E6465';
wwv_flow_api.g_varchar2_table(28) := '7828293B242874686973292E706172656E747328222E696E7075745772617070657222292E6E657874416C6C28222E696E7075745772617070657222292E656163682866756E6374696F6E2865297B242874686973292E66696E6428222E6E756D626572';
wwv_flow_api.g_varchar2_table(29) := '22292E74657874286E2B652B31297D292C242874686973292E706172656E747328222E696E7075745772617070657222292E6869646528302C66756E6374696F6E28297B242874686973292E72656D6F766528292C692E73617665456C656D656E747356';
wwv_flow_api.g_varchar2_table(30) := '616C75657328292C692E656C656D656E74436F756E742D2D7D292C617065782E6A517565727928617065784974656D292E7472696767657228226368616E676522297D656C736520692E636C656172496E7075747328242874686973292E706172656E74';
wwv_flow_api.g_varchar2_table(31) := '2829293B2266756E6374696F6E223D3D747970656F6620692E6F7074696F6E732E6F6E456C656D656E7452656D6F76652626692E6F7074696F6E732E6F6E456C656D656E7452656D6F766528652C69297D293B72657475726E20612E617070656E64286F';
wwv_flow_api.g_varchar2_table(32) := '292E617070656E642875292C617D2C66696C6C456C656D656E747356616C7565733A66756E6374696F6E2865297B76617220742C6E3D652E617474722822696422293B743D652E68746D6C28292E7265706C616365282F5B5C735C725C6E5D2B242F2C22';
wwv_flow_api.g_varchar2_table(33) := '22292E73706C697428746869732E6F7074696F6E732E736570617261746F72293B76617220692C733D652E686173436C6173732822726571756972656422293F227265717569726564223A22222C613D2428223C6469763E22292E617474722822696422';
wwv_flow_api.g_varchar2_table(34) := '2C6E2B22496E7075747322292E616464436C6173732822617065784D756C7469526F7722293B696628742E6C656E67746829666F722876617220723D303B723C742E6C656E6774683B722B2B29693D746869732E637265617465456C656D656E74287468';
wwv_flow_api.g_varchar2_table(35) := '69732E656C656D656E74496E7075742C722C745B725D292E616464436C617373286E2B22496E70757422292E616464436C6173732873292E73686F7728292C612E617070656E642869292C746869732E656C656D656E74436F756E742B2B2C746869732E';
wwv_flow_api.g_varchar2_table(36) := '616464456C656D656E744576656E74732869293B656C736520693D746869732E637265617465456C656D656E7428746869732E656C656D656E74496E7075742C302C2222292E616464436C617373286E2B22496E70757422292E73686F7728292C612E61';
wwv_flow_api.g_varchar2_table(37) := '7070656E642869292C746869732E656C656D656E74436F756E742B2B2C746869732E616464456C656D656E744576656E74732869293B72657475726E20617D2C616464456C656D656E744576656E74733A66756E6374696F6E2865297B76617220743D74';
wwv_flow_api.g_varchar2_table(38) := '6869733B2428225B69645D222C65292E62696E6428226368616E6765206B65797570206D6F7573657570222C66756E6374696F6E28297B72657475726E20742E73617665456C656D656E747356616C75657328292C21317D292C2266756E6374696F6E22';
wwv_flow_api.g_varchar2_table(39) := '3D3D747970656F6620742E6F7074696F6E732E6F6E456C656D656E744164642626742E6F7074696F6E732E6F6E456C656D656E7441646428652C74297D2C73617665456C656D656E747356616C7565733A66756E6374696F6E28297B76617220653D7468';
wwv_flow_api.g_varchar2_table(40) := '69733B696628652E656C656D656E74496E70757473297B76617220743D652E656C656D656E74496E707574732E6368696C6472656E28222E696E7075745772617070657222292C6E3D5B5D3B742E656163682866756E6374696F6E28297B76617220743D';
wwv_flow_api.g_varchar2_table(41) := '2428223A696E707574222C24287468697329292C693D5B5D3B242E6561636828742C66756E6374696F6E28297B242874686973292E6174747228226E616D6522293B692E7075736828242874686973292E76616C2829297D292C693D692E6A6F696E2865';
wwv_flow_api.g_varchar2_table(42) := '2E6F7074696F6E732E696E707574536570617261746F72292C6E2E707573682869297D293B76617220693D6E2E6A6F696E28652E6F7074696F6E732E736570617261746F72293B652E656C656D656E742E746578742869292C652E656C656D656E742E76';
wwv_flow_api.g_varchar2_table(43) := '616C2869297D7D7D2C242E666E2E617065784D756C7469526F773D66756E6374696F6E2865297B72657475726E20746869732E656163682866756E6374696F6E28297B242E6461746128746869732C22706C7567696E5F617065784D756C7469526F7722';
wwv_flow_api.g_varchar2_table(44) := '297C7C242E6461746128746869732C22706C7567696E5F617065784D756C7469526F77222C6E657720506C7567696E28746869732C6529297D297D3B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(52102032170196566)
,p_plugin_id=>wwv_flow_api.id(52089089196597213)
,p_file_name=>'js/apexMultiRow-min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
