$PBExportHeader$w_con_resumen_vtas_meses_cli_form_old.srw
forward
global type w_con_resumen_vtas_meses_cli_form_old from w_int_con_empresa
end type
type gb_7 from groupbox within w_con_resumen_vtas_meses_cli_form_old
end type
type gb_5 from groupbox within w_con_resumen_vtas_meses_cli_form_old
end type
type gb_3 from groupbox within w_con_resumen_vtas_meses_cli_form_old
end type
type gb_2 from groupbox within w_con_resumen_vtas_meses_cli_form_old
end type
type gb_1 from groupbox within w_con_resumen_vtas_meses_cli_form_old
end type
type em_anyo from u_em_campo within w_con_resumen_vtas_meses_cli_form_old
end type
type uo_mes1 from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
end type
type uo_mes2 from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
end type
type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_cli_form_old
end type
type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_cli_form_old
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
end type
type gb_4 from groupbox within w_con_resumen_vtas_meses_cli_form_old
end type
type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
end type
type rb_um from radiobutton within w_con_resumen_vtas_meses_cli_form_old
end type
type rb_piezas from radiobutton within w_con_resumen_vtas_meses_cli_form_old
end type
type rb_m2 from radiobutton within w_con_resumen_vtas_meses_cli_form_old
end type
type rb_ml from radiobutton within w_con_resumen_vtas_meses_cli_form_old
end type
type pb_1 from upb_salir within w_con_resumen_vtas_meses_cli_form_old
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_cli_form_old
end type
type cb_1 from u_boton within w_con_resumen_vtas_meses_cli_form_old
end type
type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_cli_form_old
end type
type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_cli_form_old
end type
type gb_6 from groupbox within w_con_resumen_vtas_meses_cli_form_old
end type
type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
end type
type cbx_otra from checkbox within w_con_resumen_vtas_meses_cli_form_old
end type
end forward

global type w_con_resumen_vtas_meses_cli_form_old from w_int_con_empresa
integer width = 2862
integer height = 1956
gb_7 gb_7
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
em_anyo em_anyo
uo_mes1 uo_mes1
uo_mes2 uo_mes2
lbx_comparacion lbx_comparacion
em_cantidad em_cantidad
uo_serie uo_serie
gb_4 gb_4
uo_cliente uo_cliente
rb_um rb_um
rb_piezas rb_piezas
rb_m2 rb_m2
rb_ml rb_ml
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
dw_detalle_cliente dw_detalle_cliente
dw_listado_clientes dw_listado_clientes
gb_6 gb_6
uo_formato uo_formato
cbx_otra cbx_otra
end type
global w_con_resumen_vtas_meses_cli_form_old w_con_resumen_vtas_meses_cli_form_old

forward prototypes
public subroutine f_cargar_um (datawindow data)
public subroutine f_campos_segun_meses (datawindow data)
public subroutine f_cargar_cantidad (datawindow data, string unidad)
end prototypes

public subroutine f_cargar_um (datawindow data);String Sel,moneda,nombre_moneda,serie1,serie2,cliente,&
		cli1,cli2,form1,form2,restriccion,&
		nombre_cliente, serie,unidad,formato,form_abr
Dec  cantidad,mov,vtotal,vtotalpts,por,tot,t,cant, mes1,mes2,mes
Integer r,s,c, meses, i,conta
Integer cant_tot[10,12]
DataStore d

unidad = " miles de u.m. "

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

if Trim(uo_cliente.em_codigo.text) <> "" then 
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
else
	cli1 = "."
	cli2 = "Z"
end if

if Trim(uo_formato.em_codigo.text) <> "" then 
	form1 = uo_formato.em_codigo.text
	form2 = uo_formato.em_codigo.text
else
	form1 = "."
	form2 = "Z"
end if


mes1 = Dec(uo_mes1.em_codigo.text)
mes2 = Dec(uo_mes2.em_codigo.text)
meses = mes2 - mes1 + 1

data.Reset()
data.SetRedraw(FALSE)

if not cbx_otra.checked then
	// no los verán
	restriccion = " and venlifac.cliente<> '"+trim(f_cliente_mercaderia(codigo_empresa))+"' "
else // verán los datos de la otra empresa también
	restriccion = ""
end if


data.Retrieve(codigo_empresa)
f_contador_procesos(0,100)
Sel = " SELECT empresa,serie,cliente,mes,formato,Sum((neto - impdtopp) * cambio)/1000 totalpts" +&
      " FROM   venlifac " +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
      " And    venlifac.serie between '"+serie1+"' and '"+serie2+"' "+&
      " And    venlifac.cliente between '"+cli1+"' and '"+cli2+"' "+&
      " And    venlifac.formato between '"+form1+"' and '"+form2+"' "+&		
      " And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
		restriccion +&
		" And    venlifac.mes between "+ uo_mes1.em_codigo.text+ " and "+ uo_mes2.em_codigo.text+&
		" GROUP By empresa,serie,cliente,mes,formato"+ &
		" Order By empresa,serie,cliente,mes,formato"


//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

// filtro de la cantidad. Los clientes que excluimos se recogerán en 
// el cliente "Resto"...
d.GroupCalc()
d.SetFilter("totalpts " + lbx_comparacion.text + String(Dec(em_cantidad.text),"#########"))
d.Filter()
d.GroupCalc()

//f_mensaje("totalpts " + lbx_comparacion.text + em_cantidad.text,"d.FilteredCount() "+String(d.FilteredCount()))

c = 0
tot =  0

For r = 1 To d.RowCOunt()
	c = c +1
	cliente = d.GetItemString(r,"cliente")
	serie   = d.GetItemString(r,"serie")
	mes 	  = d.GetItemNumber(r,"mes")
	formato = d.GetItemString(r,"formato")
	nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
	nombre_moneda  = f_nombre_moneda_abr(moneda)
	form_abr			= f_nombre_formato_abr(codigo_empresa,formato)
	//vtotal = d.GetItemNumber(r,"total")
	vtotalpts = d.GetItemNumber(r,"totalpts")
	cant = Int(vtotalpts)
	tot = tot + vtotalpts
	data.InsertRow(c)
	data.SetItem(c,"empresa",codigo_empresa)
	data.SetItem(c,"cliente",cliente)
	data.SetItem(c,"nombre_cliente",nombre_cliente)
	data.SetItem(c,"serie",serie)
	data.SetItem(c,"unidad",unidad)
	data.SetItem(c,"formato",form_abr)
	// Inicializamos porque sino los nulooss ...
	data.SetItem(c,"mes1",0)
	data.SetItem(c,"mes2",0)
	data.SetItem(c,"mes3",0)
	data.SetItem(c,"mes4",0)
	data.SetItem(c,"mes5",0)
	data.SetItem(c,"mes6",0)
	data.SetItem(c,"mes7",0)
	data.SetItem(c,"mes8",0)
	data.SetItem(c,"mes9",0)
	data.SetItem(c,"mes10",0)
	data.SetItem(c,"mes11",0)
	data.SetItem(c,"mes12",0)
	

	if IsNull(cant) then cant = 0
		choose case mes - mes1 + 1
			case 1
				data.SetItem(c,"mes1",cant)
			case 2
				data.SetItem(c,"mes2",cant)
			case 3
				data.SetItem(c,"mes3",cant)
			case 4				
				data.SetItem(c,"mes4",cant)				
			case 5
				data.SetItem(c,"mes5",cant)				
			case 6
				data.SetItem(c,"mes6",cant)				
			case 7
				data.SetItem(c,"mes7",cant)
			case 8
				data.SetItem(c,"mes8",cant)
			case 9
				data.SetItem(c,"mes9",cant)
			case 10
				data.SetItem(c,"mes10",cant)
			case 11
				data.SetItem(c,"mes11",cant)
			case 12
				data.SetItem(c,"mes12",cant)
		end choose

	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

d.GroupCalc()
d.SetFilter("not (totalpts " + lbx_comparacion.text + String(Dec(em_cantidad.text),"#########")+")")
d.Filter()
d.GroupCalc()

for r = 1 to d.RowCount()
	vtotalpts = d.GetItemNumber(r,"totalpts")
	if not IsNull(vtotalpts) and not (vtotalpts=0) then 
		serie = d.GetitemString(r,"serie")
		mes = d.GetItemNumber(r,"mes")
		if IsNull(cant_tot[Dec(serie),mes]) then cant_tot[Dec(serie),mes] = 0
		cant_tot[Dec(serie),mes] = cant_tot[Dec(serie),mes] + vtotalpts
	end if
next

for r = 1 to UpperBound(cant_tot,1) // recorremos las series
	for s = 1 to UpperBound(cant_tot,2) // recorremos los meses
		if Not IsNull(cant_tot[r,s]) and cant_tot[r,s] <> 0 then
			conta = data.RowCount()
			data.InsertRow(conta+1)
			data.SetItem (conta+1,"empresa",codigo_empresa)
			data.SetItem (conta+1,"cliente","999999")			
			data.SetItem (conta+1,"nombre_cliente","Resto")
			data.SetItem (conta+1,"serie",String(r,"#"))
			data.SetItem (conta+1,"formato","Resto")
			choose case s - mes1 + 1
				case 1
					data.SetItem(conta+1,"mes1",cant_tot[r,s])
				case 2
					data.SetItem(conta+1,"mes2",cant_tot[r,s])					
				case 3
					data.SetItem(conta+1,"mes3",cant_tot[r,s])					
				case 4
					data.SetItem(conta+1,"mes4",cant_tot[r,s])					
				case 5
					data.SetItem(conta+1,"mes5",cant_tot[r,s])					
				case 6
					data.SetItem(conta+1,"mes6",cant_tot[r,s])					
				case 7
					data.SetItem(conta+1,"mes7",cant_tot[r,s])					
				case 8
					data.SetItem(conta+1,"mes8",cant_tot[r,s])					
				case 9
					data.SetItem(conta+1,"mes9",cant_tot[r,s])					
				case 10
					data.SetItem(conta+1,"mes10",cant_tot[r,s])					
				case 11
					data.SetItem(conta+1,"mes11",cant_tot[r,s])					
				case 12
					data.SetItem(conta+1,"mes12",cant_tot[r,s])					
			end choose
		end if
	next
next

f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)

data.Sort()
data.GroupCalc()
f_contador_procesos(1,1)

Destroy d

end subroutine

public subroutine f_campos_segun_meses (datawindow data);String campo,campo2, etiq, total, tot
Integer meses, cont, pos, resto,anc
Constant Integer ancho = 233

meses = Dec(uo_mes2.em_codigo.text) - Dec(uo_mes1.em_codigo.text) + 1
// campos visibles
for cont = 1 to meses
	etiq  = "mes" + String(cont,"##")+"_t"
	campo = "mes" + String(cont,"##")+"_cli"
	campo2 = "mes" + String(cont,"##")+"_form"	
	total = "total_mes" + String(cont,"##")
	tot = "tot_mes" + String(cont,"##")	
	data.Modify (campo + ".Visible = true")
	data.Modify (campo2 + ".Visible = true")	
	data.Modify (etiq + ".Visible = true")
	data.Modify (total + ".Visible = true")
	data.Modify (tot + ".Visible = true")	
	data.Modify (etiq + ".text = '" + f_nombre_mes_abr(Dec(uo_mes1.em_codigo.text) + cont - 1)+"'")
next	
// campos invisibles
for cont = meses+1 to 12
	etiq = "mes" + String(cont,"##")+"_t"
	campo  = "mes" + String(cont,"##")+"_cli"
	campo2 = "mes" + String(cont,"##")+"_form"		
	total = "total_mes" + String(cont,"##")
	tot = "tot_mes" + String(cont,"##")	
	data.Modify (campo + ".Visible = false")
	data.Modify (campo2 + ".Visible = false")	
	data.Modify (etiq + ".Visible = false")
	data.Modify (total + ".Visible = false")	
	data.Modify (tot + ".Visible = false")		
next	

resto = 12 - meses

pos = 3776 - ancho * resto
data.Modify("total_t.x = " + String(pos,"######"))
data.Modify("total.x = " + String(pos,"######"))
data.Modify("total_serie.x = " + String(pos,"######"))
data.Modify("total_form.x = " + String(pos,"######"))
data.Modify("total_todos.x = " + String(pos,"######"))

pos = 4142 - ancho * resto
data.Modify("parcial_t.x = " + String(pos,"######"))
data.Modify("porc_parcial2.x = " + String(pos,"######"))
data.Modify("porc_parcial3.x = " + String(pos,"######"))
data.Modify("sum_porc_parcial.x = " + String(pos,"######"))

pos = 4485 - ancho * resto
data.Modify("porcentaje_t.x = " + String(pos,"######"))
data.Modify("porc_total.x = " + String(pos,"######"))
data.Modify("sum_porc_total.x = " + String(pos,"######"))
data.Modify("sum_porc_total2.x = " + String(pos,"######"))

anc = Dec(data.Describe("porc_total.x")) + Dec(data.Describe("porc_total.width"))
data.Modify("linea1.x2 = "  + String(anc,"######"))
data.Modify("linea2.x2 = "  + String(anc,"######"))
data.Modify("linea3.x2 = "  + String(anc,"######"))
data.Modify("linea4.x2 = "  + String(anc,"######"))
end subroutine

public subroutine f_cargar_cantidad (datawindow data, string unidad);String Sel,moneda,nombre_moneda,serie1,serie2,cliente,&
		nombre_cliente, serie,vart,uni,formato,form_abr,&
		cli1,cli2,form1,form2,restriccion
Dec  cantidad,mov,vtotal,vcant,por,tot,t,cant, mes1,mes2,mes
Integer r,s,c, meses, i,conta
Integer cant_tot[10,12]
DataStore d

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

if Trim(uo_cliente.em_codigo.text) <> "" then 
	cli1 = uo_cliente.em_codigo.text
	cli2 = uo_cliente.em_codigo.text
else
	cli1 = "."
	cli2 = "Z"
end if

if Trim(uo_formato.em_codigo.text) <> "" then 
	form1 = uo_formato.em_codigo.text
	form2 = uo_formato.em_codigo.text
else
	form1 = "."
	form2 = "Z"
end if

mes1 = Dec(uo_mes1.em_codigo.text)
mes2 = Dec(uo_mes2.em_codigo.text)
meses = mes2 - mes1 + 1

data.Reset()
data.SetRedraw(FALSE)

data.Retrieve(codigo_empresa)
f_contador_procesos(0,100)

if not cbx_otra.checked then
	// no los verán
	restriccion = " and venlifac.cliente<> '"+trim(f_cliente_mercaderia(codigo_empresa))+"' "
else // verán los datos de la otra empresa también
	restriccion = ""
end if


// Pueden ser piezas, m2 o ml, habrá que elegir y luego convertir
// si es el caso... Cogemos de venlifac (¡ojo! irá más lentito)
Sel = " SELECT empresa,serie,cliente,mes,formato,articulo,Sum(cantidad) cant" +&
      " FROM   venlifac " +&
      " WHERE  venlifac.empresa = '"+codigo_empresa+"'" +&
      " And    venlifac.serie between '"+serie1+"' and '"+serie2+"' "+&
      " And    venlifac.cliente between '"+cli1+"' and '"+cli2+"' "+&
      " And    venlifac.formato between '"+form1+"' and '"+form2+"' "+&		
      " And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
		" And    venlifac.mes between "+ uo_mes1.em_codigo.text+ " and "+ uo_mes2.em_codigo.text+&
		restriccion +&
		" GROUP By empresa,serie,cliente,mes,formato,articulo"+ &
		" Order By empresa,serie,cliente,mes,formato,articulo"


//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

// filtro de la cantidad. Los clientes que excluimos se recogerán en 
// el cliente "Resto"...
d.GroupCalc()
d.SetFilter("cant " + lbx_comparacion.text + String(Dec(em_cantidad.text),"#########"))
d.Filter()
d.GroupCalc()


c = 0
tot =  0

For r = 1 To d.RowCOunt()
	c = c +1
	cliente = d.GetItemString(r,"cliente")
	serie   = d.GetItemString(r,"serie")
	mes 	  = d.GetItemNumber(r,"mes")
	formato = d.GetItemString(r,"formato")
	nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
	nombre_moneda = f_nombre_moneda_abr(moneda)
	form_abr = f_nombre_formato_abr(codigo_empresa,formato)
	//vtotal = d.GetItemNumber(r,"total")
	vart = d.GetItemString(r,"articulo")
	vcant = d.GetItemNumber(r,"cant")
	choose case unidad
		case "piezas" // unidad de la estadística: piezas
			// convertimos de m2 o piezas --> piezas
			vcant = f_conversion_cantidad_piezas_old(codigo_empresa,vart,vcant)
			uni =  " piezas"		
		case  "m2"    // unidad de la estadística --> metros cuadrados
			vcant = f_conversion_cantidad_m2(codigo_empresa,vart,vcant)
			uni = " metros cuadrados"
		case  "ml"    // unidad de la estadística --> metros lineales
			vcant = f_conversion_cantidad_ml(codigo_empresa,vart,vcant)			
			uni = "metros lineales"
	end choose
	tot = tot + vcant
	data.InsertRow(c)
	data.SetItem(c,"empresa",codigo_empresa)
	data.SetItem(c,"cliente",cliente)
	data.SetItem(c,"nombre_cliente",nombre_cliente)
	data.SetItem(c,"serie",serie)
	data.SetItem(c,"unidad",uni)
	data.SetItem(c,"formato",form_abr)
	
	// Inicializamos porque sino los nulooss ...
	data.SetItem(c,"mes1",0)
	data.SetItem(c,"mes2",0)
	data.SetItem(c,"mes3",0)
	data.SetItem(c,"mes4",0)
	data.SetItem(c,"mes5",0)
	data.SetItem(c,"mes6",0)
	data.SetItem(c,"mes7",0)
	data.SetItem(c,"mes8",0)
	data.SetItem(c,"mes9",0)
	data.SetItem(c,"mes10",0)
	data.SetItem(c,"mes11",0)
	data.SetItem(c,"mes12",0)

	if IsNull(vcant) then vcant = 0
		choose case mes - mes1 + 1
			case 1
				data.SetItem(c,"mes1",vcant)
			case 2
				data.SetItem(c,"mes2",vcant)
			case 3
				data.SetItem(c,"mes3",vcant)
			case 4				
				data.SetItem(c,"mes4",vcant)				
			case 5
				data.SetItem(c,"mes5",vcant)				
			case 6
				data.SetItem(c,"mes6",vcant)				
			case 7
				data.SetItem(c,"mes7",vcant)
			case 8
				data.SetItem(c,"mes8",vcant)
			case 9
				data.SetItem(c,"mes9",vcant)
			case 10
				data.SetItem(c,"mes10",vcant)
			case 11
				data.SetItem(c,"mes11",vcant)
			case 12
				data.SetItem(c,"mes12",vcant)
		end choose

	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

d.GroupCalc()
d.SetFilter("not (cant " + lbx_comparacion.text + String(Dec(em_cantidad.text),"#########")+")")
d.Filter()
d.GroupCalc()
//f_mensaje("d.FilteredCount()",String(d.FilteredCount()))
//f_mensaje("d.RowCount()",String(d.RowCount()))
for r = 1 to d.RowCount()
	vcant= d.GetItemNumber(r,"cant")
	if not IsNull(vcant) and not (vcant=0) then 
		serie = d.GetitemString(r,"serie")
		mes = d.GetItemNumber(r,"mes")
		if IsNull(cant_tot[Dec(serie),mes]) then cant_tot[Dec(serie),mes] = 0
		cant_tot[Dec(serie),mes] = cant_tot[Dec(serie),mes] + vcant
	end if
next

for r = 1 to UpperBound(cant_tot,1) // recorremos las series
	for s = 1 to UpperBound(cant_tot,2) // recorremos los meses
		if Not IsNull(cant_tot[r,s]) and cant_tot[r,s] <> 0 then
			conta = data.RowCount()
			data.InsertRow(conta+1)
			data.SetItem (conta+1,"empresa",codigo_empresa)
			data.SetItem (conta+1,"cliente","999999")			
			data.SetItem (conta+1,"nombre_cliente","Resto")
			data.SetItem (conta+1,"serie",String(r,"#"))
			data.SetItem (conta+1,"formato","Resto")
			choose case s - mes1 + 1
				case 1
					data.SetItem(conta+1,"mes1",cant_tot[r,s])
				case 2
					data.SetItem(conta+1,"mes2",cant_tot[r,s])					
				case 3
					data.SetItem(conta+1,"mes3",cant_tot[r,s])					
				case 4
					data.SetItem(conta+1,"mes4",cant_tot[r,s])					
				case 5
					data.SetItem(conta+1,"mes5",cant_tot[r,s])					
				case 6
					data.SetItem(conta+1,"mes6",cant_tot[r,s])					
				case 7
					data.SetItem(conta+1,"mes7",cant_tot[r,s])					
				case 8
					data.SetItem(conta+1,"mes8",cant_tot[r,s])					
				case 9
					data.SetItem(conta+1,"mes9",cant_tot[r,s])					
				case 10
					data.SetItem(conta+1,"mes10",cant_tot[r,s])					
				case 11
					data.SetItem(conta+1,"mes11",cant_tot[r,s])					
				case 12
					data.SetItem(conta+1,"mes12",cant_tot[r,s])					
			end choose
		end if
	next
next

f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)

data.Sort()
data.GroupCalc()
f_contador_procesos(1,1)

Destroy d

end subroutine

on w_con_resumen_vtas_meses_cli_form_old.create
int iCurrent
call super::create
this.gb_7=create gb_7
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.em_anyo=create em_anyo
this.uo_mes1=create uo_mes1
this.uo_mes2=create uo_mes2
this.lbx_comparacion=create lbx_comparacion
this.em_cantidad=create em_cantidad
this.uo_serie=create uo_serie
this.gb_4=create gb_4
this.uo_cliente=create uo_cliente
this.rb_um=create rb_um
this.rb_piezas=create rb_piezas
this.rb_m2=create rb_m2
this.rb_ml=create rb_ml
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.dw_detalle_cliente=create dw_detalle_cliente
this.dw_listado_clientes=create dw_listado_clientes
this.gb_6=create gb_6
this.uo_formato=create uo_formato
this.cbx_otra=create cbx_otra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_7
this.Control[iCurrent+2]=this.gb_5
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.em_anyo
this.Control[iCurrent+7]=this.uo_mes1
this.Control[iCurrent+8]=this.uo_mes2
this.Control[iCurrent+9]=this.lbx_comparacion
this.Control[iCurrent+10]=this.em_cantidad
this.Control[iCurrent+11]=this.uo_serie
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.uo_cliente
this.Control[iCurrent+14]=this.rb_um
this.Control[iCurrent+15]=this.rb_piezas
this.Control[iCurrent+16]=this.rb_m2
this.Control[iCurrent+17]=this.rb_ml
this.Control[iCurrent+18]=this.pb_1
this.Control[iCurrent+19]=this.pb_2
this.Control[iCurrent+20]=this.cb_1
this.Control[iCurrent+21]=this.dw_detalle_cliente
this.Control[iCurrent+22]=this.dw_listado_clientes
this.Control[iCurrent+23]=this.gb_6
this.Control[iCurrent+24]=this.uo_formato
this.Control[iCurrent+25]=this.cbx_otra
end on

on w_con_resumen_vtas_meses_cli_form_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_7)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.em_anyo)
destroy(this.uo_mes1)
destroy(this.uo_mes2)
destroy(this.lbx_comparacion)
destroy(this.em_cantidad)
destroy(this.uo_serie)
destroy(this.gb_4)
destroy(this.uo_cliente)
destroy(this.rb_um)
destroy(this.rb_piezas)
destroy(this.rb_m2)
destroy(this.rb_ml)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.dw_detalle_cliente)
destroy(this.dw_listado_clientes)
destroy(this.gb_6)
destroy(this.uo_formato)
destroy(this.cbx_otra)
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen ventas clientes por meses "
This.title=istr_parametros.s_titulo_ventana

em_anyo.text = String(year(Today()))
lbx_comparacion.text = ">"
uo_mes1.em_codigo.text = "1"
uo_mes1.em_campo.text=f_nombre_mes(1)
uo_mes2.em_codigo.text = "12"
uo_mes2.em_campo.text=f_nombre_mes(Dec(uo_mes2.em_codigo.text))
dw_detalle_cliente.SetTransObject(SQLCA)
dw_listado_clientes.SetTransObject(SQLCA)

cbx_otra.text = "Ver "+f_nombre_empresa(f_mercaderia_empresa(codigo_empresa))

f_activar_campo(uo_mes1.em_campo)

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_meses_cli_form_old
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_meses_cli_form_old
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_meses_cli_form_old
end type

type gb_7 from groupbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 969
integer y = 352
integer width = 864
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Formato"
end type

type gb_5 from groupbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 32
integer y = 352
integer width = 933
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Cliente"
end type

type gb_3 from groupbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 969
integer y = 160
integer width = 498
integer height = 180
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Cantidad"
end type

type gb_2 from groupbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 270
integer y = 160
integer width = 695
integer height = 180
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Meses"
end type

type gb_1 from groupbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 27
integer y = 160
integer width = 238
integer height = 180
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Año"
end type

type em_anyo from u_em_campo within w_con_resumen_vtas_meses_cli_form_old
integer x = 55
integer y = 232
integer width = 187
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###"
end type

type uo_mes1 from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
integer x = 297
integer y = 236
integer width = 315
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_mes1.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_mes1.em_campo.text=f_nombre_mes(Dec(uo_mes1.em_codigo.text))
IF Trim(uo_mes1.em_campo.text)="" THEN 
 IF Trim(uo_mes1.em_codigo.text)<>"" Then uo_mes1.em_campo.SetFocus()
 uo_mes1.em_campo.text=""
 uo_mes1.em_codigo.text=""
END IF

end event

type uo_mes2 from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
integer x = 631
integer y = 236
integer width = 315
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_mes2.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_mes2.em_campo.text=f_nombre_mes(Dec(uo_mes2.em_codigo.text))
IF Trim(uo_mes2.em_campo.text)="" THEN 
 IF Trim(uo_mes2.em_codigo.text)<>"" Then uo_mes2.em_campo.SetFocus()
 uo_mes2.em_campo.text=""
 uo_mes2.em_codigo.text=""
END IF
end event

type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 997
integer y = 224
integer width = 174
integer height = 228
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {">","<"}
borderstyle borderstyle = stylelowered!
end type

type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_cli_form_old
integer x = 1189
integer y = 228
integer width = 256
integer taborder = 70
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
end type

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
event destroy ( )
integer x = 1490
integer y = 232
integer width = 494
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type gb_4 from groupbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 1472
integer y = 164
integer width = 539
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Serie"
end type

type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
integer x = 69
integer y = 420
integer width = 869
integer taborder = 90
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text=f_razon_genter(codigo_empresa,'C',uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

type rb_um from radiobutton within w_con_resumen_vtas_meses_cli_form_old
integer x = 1879
integer y = 388
integer width = 475
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "miles de u.m."
boolean checked = true
end type

type rb_piezas from radiobutton within w_con_resumen_vtas_meses_cli_form_old
integer x = 1879
integer y = 456
integer width = 475
integer height = 76
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "piezas"
end type

type rb_m2 from radiobutton within w_con_resumen_vtas_meses_cli_form_old
integer x = 2405
integer y = 388
integer width = 210
integer height = 76
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "m2"
end type

type rb_ml from radiobutton within w_con_resumen_vtas_meses_cli_form_old
integer x = 2405
integer y = 456
integer width = 210
integer height = 76
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "ml"
end type

type pb_1 from upb_salir within w_con_resumen_vtas_meses_cli_form_old
integer x = 2587
integer y = 132
integer width = 110
integer height = 96
integer taborder = 170
boolean bringtotop = true
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_cli_form_old
integer x = 2441
integer y = 136
integer taborder = 160
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;f_campos_segun_meses (dw_listado_clientes)

// esto va un poco lento... pregunTar a Nuria por qué
//dw_listado_clientes.Object.Data = dw_detalle_cliente.Object.Data

if rb_um.checked then
	f_cargar_um(dw_listado_clientes)
else
	if rb_piezas.checked then
		f_cargar_cantidad(dw_listado_clientes,"piezas")
	else
		if rb_m2.checked then
			f_cargar_cantidad(dw_listado_clientes,"m2")
		else
			if rb_ml.checked then
				f_cargar_cantidad(dw_listado_clientes,"ml")
			end if
		end if	
		
	end if	
end if

f_imprimir_datawindow(dw_listado_clientes)
end event

type cb_1 from u_boton within w_con_resumen_vtas_meses_cli_form_old
integer x = 2034
integer y = 164
integer width = 366
integer height = 72
integer taborder = 150
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;// campos obligatorios
// mes desde
if IsNull(uo_mes1.em_codigo.text) or trim(uo_mes1.em_codigo.text) = "" then
	f_mensaje("Atención","Campo obligatorio: Mes desde")
	f_activar_campo(uo_mes1.em_campo)
	return
end if

// mes hasta
if IsNull(uo_mes2.em_codigo.text) or trim(uo_mes2.em_codigo.text) = "" then
	f_mensaje("Atención","Campo obligatorio: Mes hasta")
	f_activar_campo(uo_mes2.em_campo)
	return
end if

// mes desde ha de ser <= que mes hasta
if Dec(uo_mes1.em_codigo.text) > Dec(uo_mes2.em_codigo.text) then
	f_mensaje("Atención","El mes desde no puede ser mayor que el mes hasta")
	f_activar_campo(uo_mes1.em_campo)
	return
end if

f_campos_segun_meses (dw_detalle_cliente)

if rb_um.checked then
	f_cargar_um(dw_detalle_cliente)
else
	if rb_piezas.checked then
		f_cargar_cantidad(dw_detalle_cliente,"piezas")
	else
		if rb_m2.checked then
			f_cargar_cantidad(dw_detalle_cliente,"m2")
		else
			if rb_ml.checked then
				f_cargar_cantidad(dw_detalle_cliente,"ml")
			end if
		end if	
		
	end if	
end if
end event

type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_cli_form_old
integer x = 32
integer y = 544
integer width = 2679
integer height = 1156
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_resumen_vtas_meses_cli_form_old"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_cli_form_old
boolean visible = false
integer x = 197
integer y = 88
integer width = 937
integer height = 464
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_resumen_vtas_meses_cli_form_2"
end type

type gb_6 from groupbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 1851
integer y = 340
integer width = 859
integer height = 200
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
end type

type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_cli_form_old
integer x = 1006
integer y = 420
integer width = 768
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 
end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Formatos"
	ue_datawindow ="dw_ayuda_formatos"
	ue_filtro = ""

end event

on uo_formato.destroy
call u_em_campo_2::destroy
end on

type cbx_otra from checkbox within w_con_resumen_vtas_meses_cli_form_old
integer x = 2030
integer y = 260
integer width = 695
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Otra empr."
end type

