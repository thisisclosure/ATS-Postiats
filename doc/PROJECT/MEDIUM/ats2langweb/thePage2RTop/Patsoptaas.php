<style>
#thePage2RTop
{
  color: #FFFFF0;
}

#thePage2RTopL
{
  text-align: left;
  padding-left: 2px;
}

#thePage2RTopL ul
{
  margin: 0px;
  padding: 0px;
  list-style-type: none;
}
#thePage2RTopL ul > li
{
  float: left;
/*
  display: inline;
*/
  border-width: 1px;
  border-color: #ffffff;
  border-right-style: double;
  margin-top: 6px;
  margin-bottom: 6px;
  padding-left: 10px;
  padding-right: 10px;
}

#thePage2RTopL td
{
  border-width: 1px;
  border-color: rgba(160,160,160,0.75);
  border-bottom-style: double;
  padding-top: 1px;
  padding-bottom: 2px;
}

.thePage2RTopL_submenu
{
  z-index: 8;
  display: none;
  position: absolute;
  border-radius: 6px;
  background-color: rgba(160,20,50,0.875);
  padding-top: 6px;
  padding-bottom: 6px;
  padding-left: 8px;
  padding-right: 8px;
}

#thePage2RTopR
{
  background-color: #FFFFF0;
}
</style>

<script>
//
// HX-2014-10:
// 8 levels should be more than enough!
//
var
theTopmenuTables =
  [0,0,0,0,0,0,0,0];
//
var theTopmenuTimeout = 0;
//
function
theTopmenuTables_hide()
{
  theTopmenuTables_hide2(0); return;
}
function
theTopmenuTables_hide2(i0)
{
  var i = i0;
  var n = theTopmenuTables.length;
  while (i < n)
  {
    var x = theTopmenuTables[i];
    if(x===0)
    {
      break;
    } else {
      x.css({display:'none'});
      theTopmenuTables[i] = 0; i = i + 1;
    } // end of [if]
  } // end of [while]
}
//
function
theTopmenuTimeout_clear()
{
  if(theTopmenuTimeout)
  {
    clearTimeout(theTopmenuTimeout); theTopmenuTimeout = 0;
  }
}
//
function
Patsoptaas_topmenu_mouseout()
{
  Patsoptaas_topmenu_mouseout2(500); return;
}
function
Patsoptaas_topmenu_mouseout2(msec)
{
//
  if(theTopmenuTimeout) clearTimeout(theTopmenuTimeout); 
  theTopmenuTimeout = // HX: [theTopmenuTimeout] must be clear!!!
  setTimeout (function(){theTopmenuTimeout=0;theTopmenuTables_hide();}, msec);
//
}
//
function
Patsoptaas_topmenu_mouseover
  (x0)
{
  var jqi, jqi2;
  jqi = jQuery(x0)
  theTopmenuTables_hide2(0);
  theTopmenuTimeout_clear( ); 
  jqi2 = jqi.next('table');
  theTopmenuTables[0] = jqi2;
  jqi2.css({display:'table'});
  jqi2.css
  (
    {top:jqi.position().top+jqi.outerHeight(true)}
  ) ; // end of [jqi2.css]
  jqi2.css({left:jqi.position().left});
  return;
}
//
function
Patsoptaas_submenu_mouseout()
{
  return;
}
function
Patsoptaas_submenu_mouseover
  (x0, i0)
{
  var jqi, jqi2;
//
  jqi = jQuery(x0);
  theTopmenuTables_hide2(i0);
  theTopmenuTimeout_clear( ); 
  jqi2 = jqi.next('table');
  theTopmenuTables[i0] = jqi2;
//
  jqi2.css({display:'table'});
  jqi2.css({top:jqi.position().top-9});
  jqi2.css
  (
    {left:jqi.position().left+jqi.outerWidth(true)+10}
  ) ; // end of [jqi2.css]
//
  return;
//
}
//
function
Patsoptaas_submenu_table_mouseout()
{
  Patsoptaas_topmenu_mouseout(); return;
}
function
Patsoptaas_submenu_table_mouseover(i0)
{
/*
  if(i0 >= 1)
  {
    alert("Patsoptaas_submenu_table_mouseover("+i0+")");
  }
*/
  theTopmenuTimeout_clear(/*void*/); return;
}
//
function
Patsoptaas_Compile_patsopt_onclick2()
{
  theTopmenuTables_hide2(0);
  if(Patsoptaas_Patsopt_tcats_flag())
  {
    Patsoptaas_Compile_patsopttc_onclick();
  } else {
    Patsoptaas_Compile_patsoptcc_onclick();
  } // end of [if]
}
function
Patsoptaas_Compile_patsopt2js_onclick2()
{
  theTopmenuTables_hide2(0); Patsoptaas_Compile_patsopt2js_onclick();
}
function
Patsoptaas_Evaluate_JS_onclick2()
{
  theTopmenuTables_hide2(0); Patsoptaas_Evaluate_JS_onclick();
}
//
</script>

<table
 width="100%" height="100%"
 cellspacing="0" cellpadding="0">
<tr>
<td width="75%">
<div
 id="thePage2RTopL"
>
<ul>
<li
 name="File"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>File</li>

<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<li
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>New File</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(1)"
>
<tr><td>Blank</td></tr>
<tr><td>Template-1</td></tr>
<tr><td>Template-2</td></tr>
</table>
</td></tr>

<tr><td>
<li
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>Load File</li>
</td></tr>

<tr><td>
<li
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>Load Example</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(1)"
>
<tr><td>Hello</td></tr>
<tr><td>Factorial</td></tr>
<tr><td>Fibonacci</td></tr>
<tr><td>Ackermann</td></tr>
</table>
</td></tr>

<tr><td>
<li
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>Load Special File</li>
<table
 width="144px"
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(1)"
>
<tr><td>
<button
 type="button"
 onclick="Patsoptaas_File_patsopt_source_onclick2()"
>Patsopt-source</button>
</td></tr>

<tr><td>
<button
 type="button"
 onclick="Patsoptaas_File_patsopt_output_onclick2()"
>Patsopt-output</button>
</td></tr>

<tr><td>
<button
 type="button"
 onclick="Patsoptaas_File_patsopt2js_output_onclick2()"
>Patsopt2js-output</button>
</td></tr>

</table>
</td></tr>

<tr><td>
<li
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>Save As...
</li>
</td></tr>

</table><!--File-->

<li
 name="Compile"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>Compile</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<button
 type="button" onclick="Patsoptaas_Compile_patsopt_onclick2()"
>Patsopt</button>
</td></tr>
<tr><td>
<button
 type="button" onclick="Patsoptaas_Compile_patsopt2js_onclick2()"
>Patsopt2js</button>
</td></tr>
</table><!--Compile-->

<li
 name="Evaluate"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>Evaluate</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<button
 type="button" onclick="Patsoptaas_Evaluate_JS_onclick2()"
>EvalJS</button>
</td></tr>
</table><!--Evaluate-->

<li
 name="Help"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>Help</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<button
 type="button" onclick="Patsoptaas_Help_About_onclick2()"
>About</button>
</td></tr>
</table><!--Help-->

</ul>
</div>

<td
 width="25%"
 style="background-color:#FFFFF0">
</td>

</tr>
</table>

<?php /* end of [Patsoptaas.php] */ ?>