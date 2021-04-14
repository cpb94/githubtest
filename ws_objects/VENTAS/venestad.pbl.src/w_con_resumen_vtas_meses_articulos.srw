$PBExportHeader$w_con_resumen_vtas_meses_articulos.srw
forward
global type w_con_resumen_vtas_meses_articulos from w_int_con_empresa
end type
type gb_7 from groupbox within w_con_resumen_vtas_meses_articulos
end type
type gb_5 from groupbox within w_con_resumen_vtas_meses_articulos
end type
type gb_3 from groupbox within w_con_resumen_vtas_meses_articulos
end type
type gb_2 from groupbox within w_con_resumen_vtas_meses_articulos
end type
type gb_1 from groupbox within w_con_resumen_vtas_meses_articulos
end type
type em_anyo from u_em_campo within w_con_resumen_vtas_meses_articulos
end type
type uo_mes1 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
end type
type uo_mes2 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
end type
type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_articulos
end type
type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_articulos
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
end type
type gb_4 from groupbox within w_con_resumen_vtas_meses_articulos
end type
type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
end type
type rb_um from radiobutton within w_con_resumen_vtas_meses_articulos
end type
type rb_piezas from radiobutton within w_con_resumen_vtas_meses_articulos
end type
type rb_m2 from radiobutton within w_con_resumen_vtas_meses_articulos
end type
type rb_ml from radiobutton within w_con_resumen_vtas_meses_articulos
end type
type pb_1 from upb_salir within w_con_resumen_vtas_meses_articulos
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_articulos
end type
type cb_1 from u_boton within w_con_resumen_vtas_meses_articulos
end type
type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_articulos
end type
type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_articulos
end type
type gb_6 from groupbox within w_con_resumen_vtas_meses_articulos
end type
type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
end type
type cbx_otra from checkbox within w_con_resumen_vtas_meses_articulos
end type
type cb_2 from commandbutton within w_con_resumen_vtas_meses_articulos
end type
type cbx_conjunta from checkbox within w_con_resumen_vtas_meses_articulos
end type
type dw_cursor_venlifac from datawindow within w_con_resumen_vtas_meses_articulos
end type
type dw_cursor_venlifac_mes from datawindow within w_con_resumen_vtas_meses_articulos
end type
end forward

global type w_con_resumen_vtas_meses_articulos from w_int_con_empresa
integer width = 2825
integer height = 1728
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
cb_2 cb_2
cbx_conjunta cbx_conjunta
dw_cursor_venlifac dw_cursor_venlifac
dw_cursor_venlifac_mes dw_cursor_venlifac_mes
end type
global w_con_resumen_vtas_meses_articulos w_con_resumen_vtas_meses_articulos

type variables
boolean detalle = true
end variables

forward prototypes
public subroutine f_campos_segun_meses (datawindow data)
public subroutine f_condiciones (datawindow data, integer row)
public subroutine f_cargar_cantidad (datawindow data, string unidad, datawindow data1)
public subroutine f_cargar_um (datawindow data, datawindow data1)
end prototypes

public subroutine f_campos_segun_meses (datawindow data);String campo,campo2, etiq, total, tot , total_mes
Integer meses, cont, pos, resto,anc
Constant Integer ancho = 233

meses = Dec(uo_mes2.em_codigo.text) - Dec(uo_mes1.em_codigo.text) + 1
// campos visibles
for cont = 1 to meses
	etiq  = "mes" + String(cont,"##")+"_t"
	campo = "mes" + String(cont,"##")+"_red"
	campo2 = "mes" + String(cont,"##")+"_form"	
	total = "total_mes" + String(cont,"##")
	tot = "tot_mes" + String(cont,"##")
	total_mes = "total_cliente_mes_" + String(cont,"##")
	data.Modify (campo + ".Visible = true")
	data.Modify (campo2 + ".Visible = true")	
	data.Modify (etiq + ".Visible = true")
	data.Modify (total + ".Visible = true")
	data.Modify (tot + ".Visible = true")
	data.Modify (total_mes + ".Visible = true")
	data.Modify (etiq + ".text = '" + f_nombre_mes_abr(Dec(uo_mes1.em_codigo.text) + cont - 1)+"'")
next	
// campos invisibles
for cont = meses+1 to 12
	etiq = "mes" + String(cont,"##")+"_t"
	campo  = "mes" + String(cont,"##")+"_red"
	campo2 = "mes" + String(cont,"##")+"_form"		
	total = "total_mes" + String(cont,"##")
	tot = "tot_mes" + String(cont,"##")	
	total_mes = "total_cliente_mes_" + String(cont,"##")
	data.Modify (campo + ".Visible = false")
	data.Modify (campo2 + ".Visible = false")	
	data.Modify (etiq + ".Visible = false")
	data.Modify (total + ".Visible = false")	
	data.Modify (tot + ".Visible = false")		
	data.Modify (total_mes + ".Visible = false")
next	

resto = 12 - meses

pos = 3776 - ancho * resto
data.Modify("total_t.x = " + String(pos,"######"))
data.Modify("total.x = " + String(pos,"######"))
data.Modify("total_serie.x = " + String(pos,"######"))
data.Modify("total_cliente.x = " + String(pos,"######"))
data.Modify("total_form.x = " + String(pos,"######"))
data.Modify("total_todos.x = " + String(pos,"######"))

pos = 4142 - ancho * resto
data.Modify("parcial_t.x = " + String(pos,"######"))
data.Modify("porc_parcial2.x = " + String(pos,"######"))
data.Modify("porc_parcial_cliente.x = " + String(pos,"######"))
data.Modify("porc_parcial3.x = " + String(pos,"######"))
data.Modify("sum_porc_parcial.x = " + String(pos,"######"))

pos = 4485 - ancho * resto
data.Modify("porcentaje_t.x = " + String(pos,"######"))
data.Modify("porc_total.x = " + String(pos,"######"))
data.Modify("porc_total_cliente.x = " + String(pos,"######"))
data.Modify("sum_porc_total.x = " + String(pos,"######"))
data.Modify("sum_porc_total2.x = " + String(pos,"######"))

anc = Dec(data.Describe("porc_total.x")) + Dec(data.Describe("porc_total.width"))
data.Modify("linea1.x2 = "  + String(anc,"######"))
data.Modify("linea2.x2 = "  + String(anc,"######"))
data.Modify("linea3.x2 = "  + String(anc,"######"))
data.Modify("linea4.x2 = "  + String(anc,"######"))
end subroutine

public subroutine f_condiciones (datawindow data, integer row);String condic1 = "",condic2=""

/* Solamente en la dw del listado ponemos las condiciones
que ha utilizado el usuario, para que se sepa bajo qué restricciones
sale el listado. En pantalla no lo ponemos porque ya se ven y quita-
ríamos espacio innecesariamente */


if data = dw_listado_clientes then
	if not(Trim(uo_serie.em_codigo.text) = "" or IsNull(uo_serie.em_codigo.text)) then
		condic2 = condic2 + "Serie: "+f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)+". "
	end if
	if not(Trim(uo_cliente.em_codigo.text) = "" or IsNull(uo_cliente.em_codigo.text)) then
		condic2 = condic2 + "Cliente: "+f_razon_genter(codigo_empresa,"C",uo_cliente.em_codigo.text) + ". "
	end if
	if not(Trim(uo_formato.em_codigo.text) = "" or IsNull(uo_formato.em_codigo.text)) then
		condic2 = condic2 + "Formato: "+f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text) + ". "
	end if

	condic1 = condic1 +	"Año: " + em_anyo.text+" "
	condic1 = condic1 + "Desde  "+uo_mes1.em_campo.text+" "
	condic1 = condic1 + "Hasta "+uo_mes2.em_campo.text+" (ambos inclusive). "	
	condic2 = condic2 + "Cantidad "+lbx_comparacion.text+" "+em_cantidad.text
	
	data.SetItem(row,"condiciones1",condic1)
	data.SetItem(row,"condiciones2",condic2)
end if
end subroutine

public subroutine f_cargar_cantidad (datawindow data, string unidad, datawindow data1);String Sel,serie1,serie2,cliente,nombre_cliente, serie,cli1,cli2, &
	restriccion,filtro,resul,empresa,uni,form1,form2
Dec  cantidad,mov,vtotal,vtotalpts,por,tot,t,cant, mes1,mes2,mes,cont
Integer r,s,c,d,reg, meses, i,j,conta,anyo,busca
boolean insertado[10]
Dec cant_uni[12],resto[10,12]
long registros,tot_mes
String v_form,vart,anterior_cliente

datastore dd2


dw_cursor_venlifac.reset()
dw_cursor_venlifac_mes.reset()

if cbx_conjunta.checked then 
	empresa = "%"
else
	empresa = codigo_empresa
end if

for i = 1 to 12
	for j = 1 to 10
		resto[j,i] = 0
		insertado[j] = false
	next
next

anyo = Dec(em_anyo.text)
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
data1.Reset()
data1.SetRedraw(FALSE)

string cad
if empresa = "%" then 
	cad = "9"
else 
	cad = empresa
end if
data.Retrieve(cad)
data1.Retrieve(cad)

f_contador_procesos(0,100)

if not cbx_otra.checked and not cbx_conjunta.checked then
	// no verán los datos de la otra empresa 
	restriccion = " and cliente<> '"+trim(f_cliente_mercaderia(codigo_empresa))+"' "
else // los verán
	restriccion = ""
end if

/* Pueden ser piezas, m2 o ml, habrá que elegir y luego convertir
 si es el caso... Convierto en la datawindow y lo recojo aqui, en el 
 campo cant_real
 Cogemos de venlifac (¡ojo! irá más lentito que el de u.m.) */
registros = dw_cursor_venlifac.retrieve(empresa,serie1,serie2,cli1,cli2,anyo,mes1,mes2,form1,form2,unidad)

//registros = dd.RowCount()

// filtro de la cantidad. Los clientes que excluimos se recogerán en 
// el cliente "Resto"...
filtro = "cant_cliente " + lbx_comparacion.text + String(Dec(em_cantidad.text),"###########0")

c = 0
tot =  0

choose case unidad
	case "piezas" // unidad de la estadística: piezas
		uni =  " piezas"		
	case  "m2"    // unidad de la estadística --> metros cuadrados
		uni = " metros cuadrados"
	case  "ml"    // unidad de la estadística --> metros lineales
		uni = " metros lineales"
end choose

For reg = 1 To registros
	empresa = dw_cursor_venlifac.GetItemString(reg,"empresa")
	cliente = dw_cursor_venlifac.GetItemString(reg,"cliente")
	serie   = dw_cursor_venlifac.GetItemString(reg,"serie")
	nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
	
	busca = data.Find("cliente ='"+cliente+"'",1,data.RowCount())
	
	if busca = 0 then // si el cliente no está todavía, lo doy de alta

		resul = dw_cursor_venlifac.Describe("evaluate ('if ("+filtro+",1,0)',"+String(reg,"###")+")")
		
	
		if resul = "1" then //inserto el cliente puesto que cumple la condición
			string otra_empresa
			otra_empresa = f_mercaderia_empresa(codigo_empresa)
			// cómo mola este if eh? 
			/* Este if es para excluir las ventas internas si la estadística
			es conjunta. */
			if not (cbx_conjunta.checked and &
				(empresa = codigo_empresa and &
				cliente = trim(f_cliente_mercaderia(codigo_empresa)))  or &
				(empresa = otra_empresa and &
				cliente = trim(f_cliente_mercaderia(otra_empresa)))) then
			// DANGER //	
				string sel2
				dec cont2
				
				sel2 = " select distinct(formato) "+&
				" from venlifac "+& 
				" where empresa like '" + empresa + "' "+&
				" and cliente = '" + cliente + "' " +&		
				" and formato between '" + form1 + "' and '" + form2 +"' "+&
				" and mes between " + String(mes1,"##") + " and " + String(mes2,"##") + " " + &
				" and anyo = " + String(Dec(em_anyo.text), "####") +&
				restriccion 
//				dd2 = f_cargar_cursor(sel2)
				f_Cargar_cursor_nuevo(sel2, dd2)
			
				for cont2 = 1 to dd2.rowcount()
					
					v_form = dd2.GetItemString(cont2,"formato")
					
					r = data.InsertRow(c)
					data1.InsertRow(c)
					c = c + 1
			
					data.SetItem(r,"empresa",empresa)
					data.SetItem(r,"cliente",cliente)
					data.SetItem(r,"nombre_cliente",nombre_cliente)
					data.SetItem(r,"serie",serie)
					data.SetItem(r,"unidad",unidad)
					data.SetItem(r,"formato",f_nombre_formato_abr(codigo_empresa,v_form))
					f_condiciones (data,r)		
	
					data1.SetItem(r,"empresa",empresa)
					data1.SetItem(r,"cliente",cliente)
					data1.SetItem(r,"nombre_cliente",nombre_cliente)
					data1.SetItem(r,"serie",serie)
					data1.SetItem(r,"unidad",unidad)
					data1.SetItem(r,"formato",f_nombre_formato_abr(codigo_empresa,v_form))
					f_condiciones (data1,r)		

					for cont = mes1 to mes2
						
						anyo  = Dec(em_anyo.text)
						
						select 	sum(cantidad),max(articulo) 
						into  	:cant_uni[cont],:vart
						from 		venlifac
						where		venlifac.empresa like :empresa
						and		venlifac.anyo = :anyo
						and		venlifac.cliente = :cliente
						and		venlifac.mes = :cont
						and		venlifac.formato = :v_form;
						
						if IsNull(cant_uni[cont]) then cant_uni[cont] = 0
			
			         choose case unidad
 						case "piezas" // unidad de la estadística: piezas
						// convertimos de m2 o piezas --> piezas
							cant_uni[cont] = f_conversion_cantidad_piezas_old(codigo_empresa,vart,cant_uni[cont])
						
						case  "m2"    // unidad de la estadística --> metros cuadrados
							cant_uni[cont] = f_conversion_cantidad_m2(codigo_empresa,vart,cant_uni[cont])
						
						case  "ml"    // unidad de la estadística --> metros lineales
							cant_uni[cont] = f_conversion_cantidad_ml(codigo_empresa,vart,cant_uni[cont])			
						
						end choose
  
						data.SetItem(r,"mes"+Trim(String(cont - mes1 + 1 ,"##")),cant_uni[cont])
						data1.SetItem(r,"mes"+Trim(String(cont - mes1 + 1 ,"##")),cant_uni[cont])
					next
					
				next
			
			end if
			
		else // el cliente no cumple la condición. Acumulamos en Resto
			if cliente <> anterior_cliente then
				
				anterior_cliente = cliente
				
				sel2 = " select distinct(formato) "+&
				" from venlifac "+& 
				" where empresa like '" + empresa + "' "+&
				" and cliente = '" + cliente + "' " +&		
				" and formato between '" + form1 + "' and '" + form2 +"' "+&
				" and mes between " + String(mes1,"##") + " and " + String(mes2,"##") + " " + &
				" and anyo = " + String(Dec(em_anyo.text), "####") +&
				restriccion
				
//				dd2 = f_cargar_cursor(sel2)	
				f_Cargar_cursor_nuevo(sel2, dd2)
			
				for cont2 = 1 to dd2.rowcount()
					
					v_form = dd2.GetItemString(cont2,"formato")
					
					for cont = mes1 to mes2
						
						anyo  = Dec(em_anyo.text)
						
						select 	sum(cantidad),max(articulo) 
						into  	:cant_uni[cont],:vart
						from 		venlifac
						where		venlifac.empresa like :empresa
						and		venlifac.anyo = :anyo
						and		venlifac.cliente = :cliente
						and		venlifac.mes = :cont
						and		venlifac.formato = :v_form;
						
						if IsNull(cant_uni[cont]) then cant_uni[cont] = 0
			
			         choose case unidad
 						case "piezas" // unidad de la estadística: piezas
						// convertimos de m2 o piezas --> piezas
							cant_uni[cont] = f_conversion_cantidad_piezas_old(codigo_empresa,vart,cant_uni[cont])
					
						case  "m2"    // unidad de la estadística --> metros cuadrados
							cant_uni[cont] = f_conversion_cantidad_m2(codigo_empresa,vart,cant_uni[cont])
						
						case  "ml"    // unidad de la estadística --> metros lineales
							cant_uni[cont] = f_conversion_cantidad_ml(codigo_empresa,vart,cant_uni[cont])			
						
						end choose
  
						resto[dec(serie),cont] = resto[dec(serie),cont]+cant_uni[cont]
						
						insertado[dec(serie)] = true
						
					next
					
				next
				
			end if
			// DANGER //				
		end if // del if resul = "1"
	end if // del id busca = 0
	f_mensaje_proceso("Leyendo facturas",reg,dw_cursor_venlifac.RowCount())
Next

/* Insertamos el cliente Resto, con todos los clientes que no 
	cumplen la condición puesta por el usuario */
	
for i = 1 to 10   	// un máximo de 10 series ...
	if insertado[i] then
		
		r = data.InsertRow(c)
		data1.InsertRow(c)
		f_condiciones (data,r)		
		f_condiciones (data1,r)		
		c = c + 1
		
		data.SetItem(r,"empresa",empresa)
		data.SetItem(r,"cliente",99999)
		data.SetItem(r,"nombre_cliente","ZZZZ(Resto)")
		data.SetItem(r,"serie",String(i,"##"))
		data.SetItem(r,"unidad",unidad)		
		data1.SetItem(r,"empresa",empresa)
		data1.SetItem(r,"cliente",99999)
		data1.SetItem(r,"nombre_cliente","ZZZZ(Resto)")
		data1.SetItem(r,"serie",String(i,"##"))
		data1.SetItem(r,"unidad",unidad)		

		for cont = mes1 to mes2
			data.SetItem(r,"mes"+Trim(String(cont - mes1 + 1,"##")),resto[i,cont])
			data1.SetItem(r,"mes"+Trim(String(cont - mes1 + 1,"##")),resto[i,cont])
		next
	end if

next

f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
data.Sort()
data.GroupCalc()
data1.SetRedraw(TRUE)
data1.Sort()
data1.GroupCalc()

f_contador_procesos(1,1)

destroy dd2
end subroutine

public subroutine f_cargar_um (datawindow data, datawindow data1);/// ESTE LISTADO NO TIENE EN CUENTA LAS LINEAS DE VENLIFAC DE CONCEPTOS \\



String sel,sel2,serie1,serie2,cliente,nombre_cliente, serie,cli1,cli2, &
	restriccion,unidad,filtro,resul,empresa,form1,form2
Dec  cantidad,mov,vtotal,vtotalpts,por,tot,t,cant, mes1,mes2,mes,cont
Integer r,s,c,d,reg, meses, i,j,conta,anyo,cont2
boolean insertado[10]
Dec cant_ptas[12],resto[10,12]
long registros
Datastore dd,dd2

unidad = " miles de u.m. "

if cbx_conjunta.checked then 
	empresa = "%"
else
	empresa = codigo_empresa
end if

for i = 1 to 12
	for j = 1 to 10
		resto[j,i] = 0
		insertado[j] = false
	next
next

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
data1.Reset()
data1.SetRedraw(FALSE)

string cad
if empresa = "%" then 
	cad = "9"
else 
	cad = empresa
end if
data.Retrieve(cad)
data1.Retrieve(cad)
f_contador_procesos(0,100)

if not cbx_otra.checked and not cbx_conjunta.checked then
	// no verán los datos de la otra empresa 
	restriccion = " and cliente<> '"+trim(f_cliente_mercaderia(codigo_empresa))+"' "
else // los verán
	restriccion = ""
end if


// dw_cursor_venfac.retrieve(codigo_empresa,serie1,serie2,cli1,cli2,dec(em_anyo.text),mes1,mes2)
if form1 ="." then
	sel = " select empresa,serie,cliente,sum((total_neto - impdtopp)*cambio) total_ptas from venfac " +&
			" where empresa like '" + empresa + "' "+&
			" and serie between '" + serie1 + "' and '" + serie2 + "' "+&
			" and cliente between '" + cli1 + "' and '" + cli2 + "' "+&		
			" and mes between " + String(mes1,"##") + " and " + String(mes2,"##") + " " + &
			" and anyo = " + String(Dec(em_anyo.text), "####") +&
			restriccion + &
			" group by empresa,serie,cliente "+&
			" order by empresa,serie,cliente "

else
	sel = " select empresa,serie,cliente,sum((neto - impdtopp)*cambio) total_ptas from venlifac " +&
			" where empresa like '" + empresa + "' "+&
			" and serie between '" + serie1 + "' and '" + serie2 + "' "+&
			" and cliente between '" + cli1 + "' and '" + cli2 + "' "+&		
			" and formato between '" + form1 + "' and '" + form2 +"' "+&
			" and mes between " + String(mes1,"##") + " and " + String(mes2,"##") + " " + &
			" and anyo = " + String(Dec(em_anyo.text), "####") +&
			restriccion + &
			" group by empresa,serie,cliente "+&
			" order by empresa,serie,cliente "
end if

//dd = f_cargar_cursor (sel)
f_Cargar_cursor_nuevo(sel, dd)


registros = dd.RowCount()

// filtro de la cantidad. Los clientes que excluimos se recogerán en 
// el cliente "Resto"...
filtro = "total_ptas " + lbx_comparacion.text + String(Dec(em_cantidad.text)*1000,"###########0")

c = 0
tot =  0


For reg = 1 To registros
	empresa = dd.GetItemString(reg,"empresa")
	cliente = dd.GetItemString(reg,"cliente")
	serie   = dd.GetItemString(reg,"serie")
	nombre_cliente = f_razon_genter(codigo_empresa,"C",cliente)
	
	//mes = dw_cursor_venfac.GetItemNumber(r,"mes")
	resul = dd.Describe("evaluate ('if ("+filtro+",1,0)',"+String(reg,"###")+")")
	//***
	//string la
	//la = "evaluate (if ('"+filtro+"',1,0),"+String(reg,"###")+")"
	//f_mensaje("resul: ",resul)
	
	//vtotalpts = dd.GetItemNumber(r,"total_ptas")
	//cant = Int(vtotalpts)
	//tot = tot + vtotalpts

	if resul = "1" then //inserto el cliente puesto que cumple la condición
		string otra_empresa
		otra_empresa = f_mercaderia_empresa(codigo_empresa)
		// cómo mola este if eh?
		if not (cbx_conjunta.checked and &
			(empresa = codigo_empresa and &
			cliente = trim(f_cliente_mercaderia(codigo_empresa)))  or &
			(empresa = otra_empresa and &
			cliente = trim(f_cliente_mercaderia(otra_empresa)))) then
			
			sel2 = " select distinct(formato) "+&
				" from venlifac "+& 
				" where empresa like '" + empresa + "' "+&
				" and cliente = '" + cliente + "' " +&		
				" and formato between '" + form1 + "' and '" + form2 +"' "+&
				" and mes between " + String(mes1,"##") + " and " + String(mes2,"##") + " " + &
				" and anyo = " + String(Dec(em_anyo.text), "####") +&
				restriccion 
//			dd2 = f_cargar_cursor(sel2)
			f_Cargar_cursor_nuevo(sel2, dd2)
			
			for cont2 = 1 to dd2.rowcount()
				String v_form
				v_form = dd2.GetItemString(cont2,"formato")
				r = data.InsertRow(c)
				data1.InsertRow(c)
				c = c + 1
		
				data.SetItem(r,"empresa",empresa)
				data.SetItem(r,"cliente",cliente)
				data.SetItem(r,"nombre_cliente",nombre_cliente)
				data.SetItem(r,"serie",serie)
				data.SetItem(r,"unidad",unidad)
				data.SetItem(r,"formato",f_nombre_formato_abr(codigo_empresa,v_form))
				f_condiciones (data,r)		
				data1.SetItem(r,"empresa",empresa)
				data1.SetItem(r,"cliente",cliente)
				data1.SetItem(r,"nombre_cliente",nombre_cliente)
				data1.SetItem(r,"serie",serie)
				data1.SetItem(r,"unidad",unidad)
				data1.SetItem(r,"formato",f_nombre_formato_abr(codigo_empresa,v_form))
				f_condiciones (data,r)		


				for cont = mes1 to mes2
					
					anyo  = Dec(em_anyo.text)
					
					select 	sum((neto - impdtopp)*cambio) 
					into  	:cant_ptas[cont]
					from 		venlifac
					where		venlifac.empresa like :empresa
					and		venlifac.anyo = :anyo
					and		venlifac.cliente = :cliente
					and		venlifac.mes = :cont
					and		venlifac.formato = :v_form;
					
					if IsNull(cant_ptas[cont]) then cant_ptas[cont] = 0
		
					data.SetItem(r,"mes"+Trim(String(cont - mes1 + 1 ,"##")),cant_ptas[cont])
					data1.SetItem(r,"mes"+Trim(String(cont - mes1 + 1 ,"##")),cant_ptas[cont])					
				next
			next
		end if
	else // el cliente no cumple la condición. Acumulamos en Resto
			sel2 = " select distinct(formato) "+&
				" from venlifac "+& 
				" where empresa like '" + empresa + "' "+&
				" and serie between '" + serie1 + "' and '" + serie2 + "' "+&
				" and cliente between '" + cli1 + "' and '" + cli2 + "' "+&		
				" and formato between '" + form1 + "' and '" + form2 +"' "+&
				" and mes between " + String(mes1,"##") + " and " + String(mes2,"##") + " " + &
				" and anyo = " + String(Dec(em_anyo.text), "####") +&
				restriccion 
//			dd2 = f_cargar_cursor(sel2)
			f_Cargar_cursor_nuevo(sel2, dd2)
			
			for cont2 = 1 to dd2.rowcount()
				v_form = dd2.GetItemString(cont2,"formato")

				for cont = mes1 to mes2
					
					anyo  = Dec(em_anyo.text)
					
					select 	sum((neto - impdtopp)*cambio) 
					into  	:cant
					from 		venlifac
					where		venlifac.empresa like :empresa
					and		venlifac.anyo = :anyo
					and		venlifac.cliente = :cliente
					and		venlifac.mes = :cont
					and		venlifac.formato = :v_form;
					
					if IsNull(cant) then cant = 0
					resto[Dec(serie),cont] = resto[Dec(serie),cont] + cant
					insertado[Dec(serie)] = true
							
				next
			next
		
	end if
	
	f_mensaje_proceso("Leyendo facturas",reg,dd.RowCount())
Next

/* Insertamos el cliente Resto, con todos los clientes que no 
	cumplen la condición puesta por el usuario */
for i = 1 to 10 // un máximo de 10 series ...
	if insertado[i] then
		r = data.InsertRow(c)
		data1.InsertRow(c)
		f_condiciones (data,r)		
		f_condiciones (data1,r)		
		c = c + 1
		
		data.SetItem(r,"empresa",empresa)
		data.SetItem(r,"cliente",99999)
		data.SetItem(r,"nombre_cliente","ZZZZ(Resto)")
		data.SetItem(r,"serie",String(i,"##"))
		data.SetItem(r,"unidad",unidad)		
		data.SetItem(r,"formato","Todos")
		data1.SetItem(r,"empresa",empresa)
		data1.SetItem(r,"cliente",99999)
		data1.SetItem(r,"nombre_cliente","ZZZZ(Resto)")
		data1.SetItem(r,"serie",String(i,"##"))
		data1.SetItem(r,"unidad",unidad)		
		data1.SetItem(r,"formato","Todos")

		for cont = mes1 to mes2
			data.SetItem(r,"mes"+Trim(String(cont - mes1 + 1,"##")),resto[i,cont])
			data1.SetItem(r,"mes"+Trim(String(cont - mes1 + 1,"##")),resto[i,cont])
		next
	end if

next

f_mensaje_proceso("Espere Por Favor",99,100)
data.SetRedraw(TRUE)
data.Sort()
data.GroupCalc()
data1.SetRedraw(TRUE)
data1.Sort()
data1.GroupCalc()

f_contador_procesos(1,1)


destroy dd
destroy dd2
end subroutine

on w_con_resumen_vtas_meses_articulos.create
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
this.cb_2=create cb_2
this.cbx_conjunta=create cbx_conjunta
this.dw_cursor_venlifac=create dw_cursor_venlifac
this.dw_cursor_venlifac_mes=create dw_cursor_venlifac_mes
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
this.Control[iCurrent+26]=this.cb_2
this.Control[iCurrent+27]=this.cbx_conjunta
this.Control[iCurrent+28]=this.dw_cursor_venlifac
this.Control[iCurrent+29]=this.dw_cursor_venlifac_mes
end on

on w_con_resumen_vtas_meses_articulos.destroy
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
destroy(this.cb_2)
destroy(this.cbx_conjunta)
destroy(this.dw_cursor_venlifac)
destroy(this.dw_cursor_venlifac_mes)
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen ventas clientes por meses y formato"
This.title=istr_parametros.s_titulo_ventana

em_anyo.text = String(year(Today()))
lbx_comparacion.text = ">"
uo_mes1.em_codigo.text = "1"
uo_mes1.em_campo.text=f_nombre_mes(1)
uo_mes2.em_codigo.text = "12"
uo_mes2.em_campo.text=f_nombre_mes(Dec(uo_mes2.em_codigo.text))
dw_detalle_cliente.SetTransObject(SQLCA)
dw_listado_clientes.SetTransObject(SQLCA)
dw_cursor_venlifac.SetTransObject(sqlca)
dw_cursor_venlifac_mes.SetTransObject(sqlca)

cbx_otra.text = "Ver "+f_nombre_empresa(f_mercaderia_empresa(codigo_empresa))

f_activar_campo(uo_mes1.em_campo)

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_meses_articulos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_meses_articulos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_meses_articulos
end type

type gb_7 from groupbox within w_con_resumen_vtas_meses_articulos
integer x = 969
integer y = 352
integer width = 494
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

type gb_5 from groupbox within w_con_resumen_vtas_meses_articulos
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

type gb_3 from groupbox within w_con_resumen_vtas_meses_articulos
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

type gb_2 from groupbox within w_con_resumen_vtas_meses_articulos
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

type gb_1 from groupbox within w_con_resumen_vtas_meses_articulos
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

type em_anyo from u_em_campo within w_con_resumen_vtas_meses_articulos
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

type uo_mes1 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
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

type uo_mes2 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
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

type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_articulos
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
string item[] = {"<>","<",">=","<=",">","="}
borderstyle borderstyle = stylelowered!
end type

type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_articulos
integer x = 1189
integer y = 228
integer width = 256
integer taborder = 80
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
end type

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
event destroy ( )
integer x = 1490
integer y = 232
integer width = 494
integer taborder = 90
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

type gb_4 from groupbox within w_con_resumen_vtas_meses_articulos
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

type uo_cliente from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
integer x = 69
integer y = 420
integer width = 869
integer taborder = 100
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

type rb_um from radiobutton within w_con_resumen_vtas_meses_articulos
integer x = 1879
integer y = 388
integer width = 475
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
string text = "miles de u.m."
boolean checked = true
end type

type rb_piezas from radiobutton within w_con_resumen_vtas_meses_articulos
integer x = 1879
integer y = 456
integer width = 475
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
string text = "piezas"
end type

type rb_m2 from radiobutton within w_con_resumen_vtas_meses_articulos
integer x = 2405
integer y = 388
integer width = 210
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
string text = "m2"
end type

type rb_ml from radiobutton within w_con_resumen_vtas_meses_articulos
integer x = 2405
integer y = 456
integer width = 210
integer height = 76
integer taborder = 150
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

type pb_1 from upb_salir within w_con_resumen_vtas_meses_articulos
integer x = 2587
integer y = 136
integer width = 110
integer height = 96
integer taborder = 180
boolean bringtotop = true
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_articulos
integer x = 2441
integer y = 136
integer taborder = 170
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;//f_campos_segun_meses (dw_listado_clientes)
//
//// esto va un poco lento... pregunTar a Nuria por qué
////dw_listado_clientes.Object.Data = dw_detalle_cliente.Object.Data
//
//if rb_um.checked then
//	f_cargar_um(dw_listado_clientes)
//else
////	f_mensaje("Atención","opciones no disponibles de momento...")	
//	if rb_piezas.checked then
//		f_cargar_cantidad(dw_listado_clientes,"piezas")
//	else
//		if rb_m2.checked then
//			f_cargar_cantidad(dw_listado_clientes,"m2")
//		else
//			if rb_ml.checked then
//				f_cargar_cantidad(dw_listado_clientes,"ml")
//			end if
//		end if	
//		
//	end if	
//end if
//
if dw_detalle_cliente.rowcount() >0 then
	f_imprimir_datawindow(dw_listado_clientes)
else
	cb_1.triggerevent(clicked!)
	f_imprimir_datawindow(dw_listado_clientes)
end if
	
end event

type cb_1 from u_boton within w_con_resumen_vtas_meses_articulos
integer x = 1495
integer y = 464
integer width = 338
integer height = 72
integer taborder = 160
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
f_campos_segun_meses (dw_listado_clientes)
if rb_um.checked then
	f_cargar_um(dw_detalle_cliente,dw_listado_clientes)
else
//	f_mensaje("Atención","opciones no disponibles de momento...")
	if rb_piezas.checked then
		f_cargar_cantidad(dw_detalle_cliente,"piezas",dw_listado_clientes)
	else
		if rb_m2.checked then
			f_cargar_cantidad(dw_detalle_cliente,"m2",dw_listado_clientes)
		else
			if rb_ml.checked then
				f_cargar_cantidad(dw_detalle_cliente,"ml",dw_listado_clientes)
			end if
		end if	
		
	end if	
end if
end event

type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_articulos
integer x = 32
integer y = 552
integer width = 2679
integer height = 916
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_resumen_vtas_meses_cli_form"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_articulos
boolean visible = false
integer x = 201
integer y = 88
integer width = 937
integer height = 464
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_resumen_vtas_meses_cli_form"
end type

type gb_6 from groupbox within w_con_resumen_vtas_meses_articulos
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

type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_articulos
integer x = 992
integer y = 420
integer width = 439
integer taborder = 110
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

type cbx_otra from checkbox within w_con_resumen_vtas_meses_articulos
integer x = 2030
integer y = 264
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

type cb_2 from commandbutton within w_con_resumen_vtas_meses_articulos
integer x = 1495
integer y = 392
integer width = 338
integer height = 72
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Resumen"
end type

event clicked;if detalle then
	dw_detalle_cliente.modify("datawindow.detail.height=0")
	dw_detalle_cliente.modify("datawindow.trailer.2.height=0")
	dw_listado_clientes.modify("datawindow.detail.height=0")
	dw_listado_clientes.modify("datawindow.trailer.2.height=0")
	cb_2.text="Detalle"
else
	dw_detalle_cliente.modify("datawindow.detail.height=77")
	dw_detalle_cliente.modify("datawindow.trailer.2.height=77")
	dw_listado_clientes.modify("datawindow.detail.height=77")
	dw_listado_clientes.modify("datawindow.trailer.2.height=77")
	cb_2.text="Resumen"
end if

detalle=not detalle
end event

type cbx_conjunta from checkbox within w_con_resumen_vtas_meses_articulos
integer x = 2030
integer y = 184
integer width = 375
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Conjunta"
end type

type dw_cursor_venlifac from datawindow within w_con_resumen_vtas_meses_articulos
boolean visible = false
integer x = 754
integer y = 12
integer width = 494
integer height = 360
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_cursor_cantidad_formato"
boolean livescroll = true
end type

type dw_cursor_venlifac_mes from datawindow within w_con_resumen_vtas_meses_articulos
boolean visible = false
integer x = 1262
integer y = 8
integer width = 494
integer height = 360
integer taborder = 160
boolean bringtotop = true
string dataobject = "dw_cursor_cantidad2_formato"
boolean livescroll = true
end type

