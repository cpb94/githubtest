$PBExportHeader$w_con_resumen_vtas_meses_modelos.srw
forward
global type w_con_resumen_vtas_meses_modelos from w_int_con_empresa
end type
type gb_20 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type gb_6 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type gb_9 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type gb_3 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type gb_1 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type em_anyo from u_em_campo within w_con_resumen_vtas_meses_modelos
end type
type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_modelos
end type
type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_modelos
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
end type
type gb_4 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type rb_um from radiobutton within w_con_resumen_vtas_meses_modelos
end type
type rb_piezas from radiobutton within w_con_resumen_vtas_meses_modelos
end type
type rb_m2 from radiobutton within w_con_resumen_vtas_meses_modelos
end type
type rb_ml from radiobutton within w_con_resumen_vtas_meses_modelos
end type
type pb_1 from upb_salir within w_con_resumen_vtas_meses_modelos
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_modelos
end type
type cb_1 from u_boton within w_con_resumen_vtas_meses_modelos
end type
type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_modelos
end type
type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_modelos
end type
type uo_calidad from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
end type
type gb_5 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type uo_familia from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
end type
type gb_7 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
end type
type gb_8 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type em_tono from u_em_campo within w_con_resumen_vtas_meses_modelos
end type
type em_desde from u_em_campo within w_con_resumen_vtas_meses_modelos
end type
type em_hasta from u_em_campo within w_con_resumen_vtas_meses_modelos
end type
type st_1 from statictext within w_con_resumen_vtas_meses_modelos
end type
type gb_10 from groupbox within w_con_resumen_vtas_meses_modelos
end type
type cbx_otra from checkbox within w_con_resumen_vtas_meses_modelos
end type
type cb_2 from commandbutton within w_con_resumen_vtas_meses_modelos
end type
type cbx_conjunta from checkbox within w_con_resumen_vtas_meses_modelos
end type
end forward

global type w_con_resumen_vtas_meses_modelos from w_int_con_empresa
integer width = 2834
integer height = 1744
gb_20 gb_20
gb_6 gb_6
gb_9 gb_9
gb_3 gb_3
gb_1 gb_1
em_anyo em_anyo
lbx_comparacion lbx_comparacion
em_cantidad em_cantidad
uo_serie uo_serie
gb_4 gb_4
rb_um rb_um
rb_piezas rb_piezas
rb_m2 rb_m2
rb_ml rb_ml
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
dw_detalle_cliente dw_detalle_cliente
dw_listado_clientes dw_listado_clientes
uo_calidad uo_calidad
gb_5 gb_5
uo_familia uo_familia
gb_7 gb_7
uo_formato uo_formato
gb_8 gb_8
em_tono em_tono
em_desde em_desde
em_hasta em_hasta
st_1 st_1
gb_10 gb_10
cbx_otra cbx_otra
cb_2 cb_2
cbx_conjunta cbx_conjunta
end type
global w_con_resumen_vtas_meses_modelos w_con_resumen_vtas_meses_modelos

type variables
boolean detalle = false
String otra_empresa
end variables

forward prototypes
public subroutine f_condiciones (datawindow data, integer row)
public subroutine f_cargar_cantidad (datawindow data, string unidad, datawindow data1)
public subroutine f_cargar_um (datawindow data, datawindow data1)
end prototypes

public subroutine f_condiciones (datawindow data, integer row);String condic1 = "",condic2=""

/* Solamente en la dw del listado ponemos las condiciones
que ha utilizado el usuario, para que se sepa bajo qué restricciones
sale el listado. En pantalla no lo ponemos porque ya se ven y quita-
ríamos espacio innecesariamente */

condic1 = "Año: " + em_anyo.text+" "

if data = dw_listado_clientes then
	if not(Trim(uo_serie.em_codigo.text) = "" or IsNull(uo_serie.em_codigo.text)) then
		condic1 = condic1 + "Serie: "+f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)+". "
	end if
	
	if not(lbx_comparacion.text = "")then
		condic1 = condic1 + "Cantidad "+lbx_comparacion.text+" "+em_cantidad.text
	end if
	
	if not(Trim(uo_calidad.em_campo.text) = "" or IsNull(uo_formato.em_campo.text)) then
		condic1 = condic1 + "Calidad: "+ uo_formato.em_campo.text + ". "
	end if
	
	if not(Trim(uo_familia.em_codigo.text) = "" or IsNull(uo_familia.em_codigo.text)) then
		condic2 = condic2 + "Familia: "+ uo_familia.em_campo.text + ". "
	end if

	if not(Trim(uo_formato.em_codigo.text) = "" or IsNull(uo_formato.em_codigo.text)) then
		condic2 = condic2 + "Formato: "+ uo_formato.em_campo.text + ". "
	end if

	if not(Trim(em_tono.text) = "" or IsNull(em_tono.text)) then
		condic2 = condic2 + "Tono: "+ em_tono.text + ". "
	end if

	if not(Trim(em_desde.text) = "" or IsNull(em_desde.text)) then
		condic2 = condic2 + "Desde: "+ em_desde.text + " hasta:" + em_hasta.text + " ."
	end if
	
	data.SetItem(row,"condicion1",condic1)
	data.SetItem(row,"condicion2",condic2)
end if
end subroutine

public subroutine f_cargar_cantidad (datawindow data, string unidad, datawindow data1);String Sel,moneda,nombre_moneda,serie1,serie2,empresa,&
		serie,vart,uni,cal1,cal2,to1,to2,ini1,ini2,&
		fam1,fam2,form1,form2,fam,form,cal,tono,nombre_articulo,&
		nom_fam, nom_form,restriccion,filtro,cliente
Dec  cantidad,mov,vtotal,vcant,por,tot,t,cant
Integer r,s,c,  i,conta
Integer cant_resto[10]
long pos

DataStore d

for c=1 to 10
	cant_resto[c] = 0
next

if cbx_conjunta.checked then 
	empresa = "%"
else
	empresa = codigo_empresa
end if

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

if Trim(uo_calidad.em_codigo.text) <> "" then 
	cal1 = uo_calidad.em_codigo.text
	cal2 = uo_calidad.em_codigo.text
else
	cal1 = "."
	cal2 = "Z"
end if

if Trim(uo_familia.em_codigo.text) <> "" then 
	fam1 = uo_familia.em_codigo.text
	fam2 = uo_familia.em_codigo.text
else
	fam1 = "."
	fam2 = "Z"
end if

if Trim(uo_formato.em_codigo.text) <> "" then 
	form1 = uo_formato.em_codigo.text
	form2 = uo_formato.em_codigo.text
else
	form1 = "."
	form2 = "Z"
end if


if Trim(em_tono.text) <> "" then 
	to1 = em_tono.text
	to2 = em_tono.text
else
	to1 = "."
	to2 = "Z"
end if

if (Trim(em_desde.text)<>"") and (Trim(em_hasta.text)<>"") then
	ini1 = em_desde.text + "."
	ini2 = em_hasta.text + "Z"
else
	ini1 = "."
	ini2 = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
end if

data.Reset()
data.SetRedraw(FALSE)
data.Retrieve(empresa)
data1.Reset()
data1.SetRedraw(FALSE)
data1.Retrieve(empresa)

if not cbx_otra.checked then
	// no los verán
	restriccion = " and venlifac.cliente<> '"+trim(f_cliente_mercaderia(codigo_empresa))+"' "
else // verán los datos de la otra empresa también
	restriccion = ""
end if

f_contador_procesos(0,100)

// Pueden ser piezas, m2 o ml, habrá que elegir y luego convertir
// si es el caso... Cogemos de venlifac (¡ojo! irá más lentito)
Sel = " SELECT empresa,serie,cliente,familia,formato,articulo,calidad,tonochar,Sum(cantidad) cant" +&      
		" FROM   venlifac " +&
      " WHERE  venlifac.empresa like '"+empresa+"'" +&
      " And    venlifac.serie between '"+serie1+"' and '"+serie2+"' "+&
      " And    venlifac.familia between '"+fam1+"' and '"+fam2+"' "+&
      " And    venlifac.formato between '"+form1+"' and '"+form2+"' "+&		
      " And    venlifac.descripcion between '"+ini1+"' and '"+ini2+"' "+&		
      " And    venlifac.calidad between '"+cal1+"' and '"+cal2+"' "+&		
      " And    venlifac.tonochar between '"+to1+"' and '"+to2+"' "+&				
      " And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
		restriccion+&
		" GROUP By empresa,serie,cliente,familia,formato,articulo,calidad,tonochar"+ &
		" Order By empresa,serie,cliente,familia,formato,articulo,calidad,tonochar"

		
//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

// filtro de la cantidad. Los clientes que excluimos se recogerán en 
// el cliente "Resto"...

dec resul = 0

c = 0
tot =  0
otra_empresa = f_mercaderia_empresa(codigo_empresa)

For r = 1 To d.RowCOunt()
		
	serie    = d.GetItemString(r,"serie")
	vcant = d.GetItemNumber(r,"cant")
	vart  = d.GetItemString(r,"articulo")
	cliente = d.GetItemString(r,"cliente")
	if not (cbx_conjunta.checked and &
			(empresa = codigo_empresa and &
			cliente = trim(f_cliente_mercaderia(codigo_empresa)))  or &
			(empresa = otra_empresa and &
			cliente = trim(f_cliente_mercaderia(otra_empresa)))) then

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
		
		// Inicializamos porque sino los nulooss ...
		
		if IsNull(vcant) then vcant = 0
	
	//	f_mensaje("lbx_comparacion.text",lbx_comparacion.text)
		choose case lbx_comparacion.text
			case ">"
				if vcant > Dec(em_cantidad.text) then resul =1
			case "<"
				if vcant < Dec(em_cantidad.text) then resul =1
			case ">="
				if vcant >= Dec(em_cantidad.text) then resul =1
			case "<="
				if vcant <= Dec(em_cantidad.text) then resul =1
			case "<>"
				if vcant <> Dec(em_cantidad.text) then resul =1
			case "="
				if vcant = Dec(em_cantidad.text) then resul =1
		end choose		
		
		if resul = 1 then
			resul = 0	
			c = c +1
			
			serie   = d.GetItemString(r,"serie")
			nombre_articulo = f_nombre_articulo(codigo_empresa,vart)
			fam   = d.GetItemString(r,"familia")	
			nom_fam = f_nombre_familia(codigo_empresa,fam)
			form  = d.GetItemString(r,"formato")
			nom_form = f_nombre_formato_abr(codigo_empresa,form)	
			cal 	= d.GetItemString(r,"calidad")
			tono  = d.GetItemString(r,"tonochar")
			
			pos=data.InsertRow(c)
			data1.InsertRow(c)
			f_condiciones(data,pos)
			f_condiciones(data1,pos)
	
			data.SetItem(pos,"empresa",empresa)
			data.SetItem(pos,"articulo",vart)
			data.SetItem(pos,"nombre_articulo",nombre_articulo)
			data.SetItem(pos,"familia",fam)
			data.SetItem(pos,"formato",form)
			data.SetItem(pos,"nombre_familia",nom_fam)
			data.SetItem(pos,"nombre_formato",nom_form)
			data.SetItem(pos,"calidad",cal)
			data.SetItem(pos,"tono",tono)	
			data.SetItem(pos,"serie",serie)
			data.SetItem(pos,"unidad",uni)			
			data.SetItem(pos,"cantidad",vcant)
		
			data1.SetItem(pos,"empresa",empresa)
			data1.SetItem(pos,"articulo",vart)
			data1.SetItem(pos,"nombre_articulo",nombre_articulo)
			data1.SetItem(pos,"familia",fam)
			data1.SetItem(pos,"formato",form)
			data1.SetItem(pos,"nombre_familia",nom_fam)
			data1.SetItem(pos,"nombre_formato",nom_form)
			data1.SetItem(pos,"calidad",cal)
			data1.SetItem(pos,"tono",tono)	
			data1.SetItem(pos,"serie",serie)
			data1.SetItem(pos,"unidad",uni)			
			data1.SetItem(pos,"cantidad",vcant)

			f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
		else
			cant_resto[Dec(serie)] = cant_resto[Dec(serie)] + vcant
		end if
	end if // del super if
Next

//d.GroupCalc()
//d.SetFilter("not (cant " + lbx_comparacion.text + String(Dec(em_cantidad.text),"#########")+")")
//d.Filter()
//d.GroupCalc()
////f_mensaje("d.FilteredCount()",String(d.FilteredCount()))
////f_mensaje("d.RowCount()",String(d.RowCount()))
//for r = 1 to d.RowCount()
//	vcant= d.GetItemNumber(r,"cant")
//	if not IsNull(vcant) and not (vcant=0) then 
//		serie = d.GetitemString(r,"serie")
//		if IsNull(cant_tot[Dec(serie)]) then cant_tot[Dec(serie)] = 0
//		cant_tot[Dec(serie)] = cant_tot[Dec(serie)] + vcant
//	end if
//next

for r = 1 to UpperBound(cant_resto,1) // recorremos las series
	if Not IsNull(cant_resto[r]) and cant_resto[r] <> 0 then
		conta = data.RowCount()
		
		f_condiciones(data,conta)
		f_condiciones(data1,conta)
		
		data.InsertRow(conta+1)
		data.SetItem (conta+1,"empresa",codigo_empresa)
		data.SetItem (conta+1,"articulo","Z")			
		data.SetItem (conta+1,"nombre_articulo","ZZZResto")
		data.SetItem (conta+1,"familia","Z")
		data.SetItem (conta+1,"formato","Z")		
		data.SetItem (conta+1,"serie",String(r,"#"))
		data.SetItem(conta+1,"cantidad",cant_resto[r])
		
		data1.InsertRow(conta+1)
		data1.SetItem (conta+1,"empresa",codigo_empresa)
		data1.SetItem (conta+1,"articulo","Z")			
		data1.SetItem (conta+1,"nombre_articulo","ZZZResto")
		data1.SetItem (conta+1,"familia","Z")
		data1.SetItem (conta+1,"formato","Z")		
		data1.SetItem (conta+1,"serie",String(r,"#"))
		data1.SetItem(conta+1,"cantidad",cant_resto[r])
		
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

Destroy d

end subroutine

public subroutine f_cargar_um (datawindow data, datawindow data1);String Sel,moneda,nombre_moneda,serie1,serie2,articulo,empresa,&
		nombre_articulo, serie,unidad,cli1,cli2,fam,form,tono,cal,&
		cal1,cal2,fam1,fam2,form1,form2,to1,to2,ini1,ini2,&
		nom_fam, nom_form,restriccion,filtro,resul,cliente
Dec  cantidad,mov,vtotal,vtotalpts,por,tot,t,cant, mes1,mes2,mes
Integer r,s,c, meses, i,conta
Long cant_tot[10],resto[10]
long pos
DataStore d

for i = 1 to 10
	resto[10] = 0
next

if cbx_conjunta.checked then 
	empresa = "%"
else
	empresa = codigo_empresa
end if

unidad = " miles de u.m. "

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if

if Trim(uo_calidad.em_codigo.text) <> "" then 
	cal1 = uo_calidad.em_codigo.text
	cal2 = uo_calidad.em_codigo.text
else
	cal1 = "."
	cal2 = "Z"
end if

if Trim(uo_familia.em_codigo.text) <> "" then 
	fam1 = uo_familia.em_codigo.text
	fam2 = uo_familia.em_codigo.text
else
	fam1 = "."
	fam2 = "Z"
end if

if Trim(uo_formato.em_codigo.text) <> "" then 
	form1 = uo_formato.em_codigo.text
	form2 = uo_formato.em_codigo.text
else
	form1 = "."
	form2 = "Z"
end if


if Trim(em_tono.text) <> "" then 
	to1 = em_tono.text
	to2 = em_tono.text
else
	to1 = "."
	to2 = "Z"
end if

if (Trim(em_desde.text)<>"") and (Trim(em_hasta.text)<>"") then
	ini1 = em_desde.text + '.'
	ini2 = em_hasta.text + 'Z'
else
	ini1 = "."
	ini2 = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
end if


data.Reset()
data.SetRedraw(FALSE)
data1.Reset()
data1.SetRedraw(FALSE)

if not cbx_otra.checked then
	// no los verán
	restriccion = " and venlifac.cliente<> '"+trim(f_cliente_mercaderia(codigo_empresa))+"' "
else // verán los datos de la otra empresa también
	restriccion = ""
end if

data.Retrieve(empresa)
data1.Retrieve(empresa)
f_contador_procesos(0,100)
Sel = " SELECT empresa,serie,cliente,familia,formato,articulo,calidad,tonochar,Sum((neto - impdtopp) * cambio) totalpts" +&
      " FROM   venlifac " +&
      " WHERE  venlifac.empresa like '"+empresa+"'" +&
      " And    venlifac.serie between '"+serie1+"' and '"+serie2+"' "+&
      " And    venlifac.familia between '"+fam1+"' and '"+fam2+"' "+&
      " And    venlifac.formato between '"+form1+"' and '"+form2+"' "+&		
      " And    venlifac.descripcion between '"+ini1+"' and '"+ini2+"' "+&		
      " And    venlifac.calidad between '"+cal1+"' and '"+cal2+"' "+&		
      " And    venlifac.tonochar between '"+to1+"' and '"+to2+"' "+&				
      " And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
		restriccion +&
		" GROUP By empresa,serie,cliente,familia,formato,articulo,calidad,tonochar"+ &
		" Order By empresa,serie,cliente,familia,formato,articulo,calidad,tonochar"
//		" GROUP By empresa,serie,cliente,familia,formato,articulo,calidad,tonochar"+ &
//		" Order By empresa,serie,cliente,familia,formato,articulo,calidad,tonochar"

//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

// filtro de la cantidad. Los clientes que excluimos se recogerán en 
// el cliente "Resto"...

filtro ="totalpts " + lbx_comparacion.text + String(Dec(em_cantidad.text)*1000,"#########0")

c = 0
tot =  0

otra_empresa = f_mercaderia_empresa(codigo_empresa)


For r = 1 To d.RowCount()
	c = c +1
	resul = d.Describe("evaluate ('if ("+filtro+",1,0)',"+String(r,"###")+")")
	serie    = d.GetItemString(r,"serie")
	vtotalpts = d.GetItemNumber(r,"totalpts")
	cliente  = d.GetItemString(r,"cliente")
	if not (cbx_conjunta.checked and &
			(empresa = codigo_empresa and &
			cliente = trim(f_cliente_mercaderia(codigo_empresa)))  or &
			(empresa = otra_empresa and &
			cliente = trim(f_cliente_mercaderia(otra_empresa)))) then

		if resul = "1" then
			
			articulo = d.GetItemString(r,"articulo")
			cal		= d.GetItemString(r,"calidad")
			tono		= d.GetItemString(r,"tonochar")	
			nombre_articulo = f_nombre_articulo (codigo_empresa,articulo)
			fam 		= d.GetItemString(r,"familia")
			form 		= d.GetItemString(r,"formato")
			nom_fam 	= f_nombre_familia(codigo_empresa,fam)
			nom_form = f_nombre_formato_abr(codigo_empresa,form)
	//		cant = Int(vtotalpts)
			//tot = tot + vtotalpts
			pos = data.InsertRow(c)
			data1.InsertRow(c)
			f_condiciones(data,pos)
			f_condiciones(data1,pos)
			
			data.SetItem(pos,"empresa",codigo_empresa)
			data.SetItem(pos,"articulo",articulo)
			data.SetItem(pos,"nombre_articulo",nombre_articulo)	
			data.SetItem(pos,"familia",fam)
			data.SetItem(pos,"formato",form)	
			data.SetItem(pos,"nombre_familia",nom_fam)
			data.SetItem(pos,"nombre_formato",nom_form)	
			data.SetItem(pos,"calidad",cal)	
			data.SetItem(pos,"tono",tono)		
			data.SetItem(pos,"serie",serie)
			data.SetItem(pos,"unidad",unidad)

			data1.SetItem(pos,"empresa",codigo_empresa)
			data1.SetItem(pos,"articulo",articulo)
			data1.SetItem(pos,"nombre_articulo",nombre_articulo)	
			data1.SetItem(pos,"familia",fam)
			data1.SetItem(pos,"formato",form)	
			data1.SetItem(pos,"nombre_familia",nom_fam)
			data1.SetItem(pos,"nombre_formato",nom_form)	
			data1.SetItem(pos,"calidad",cal)	
			data1.SetItem(pos,"tono",tono)		
			data1.SetItem(pos,"serie",serie)
			data1.SetItem(pos,"unidad",unidad)

			if IsNull(cant) then cant = 0
			//f_mensaje("cant",String(cant))
			data.SetItem(pos,"cantidad",vtotalpts)
			data1.SetItem(pos,"cantidad",vtotalpts)
		else
			resto[Dec(serie)] = resto[Dec(serie)] + vtotalpts		
		end if
	end if // del super if
	f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
Next

//d.GroupCalc()
//d.SetFilter("not (totalpts " + lbx_comparacion.text + String(Dec(em_cantidad.text),"#########")+")")
//d.Filter()
//d.GroupCalc()
//
//for r = 1 to d.RowCount()
//	vtotalpts = d.GetItemNumber(r,"totalpts")
//	if not IsNull(vtotalpts) and not (vtotalpts=0) then 
//		serie = d.GetitemString(r,"serie")
//		if IsNull(cant_tot[Dec(serie)]) then cant_tot[Dec(serie)] = 0
//		cant_tot[Dec(serie)] = cant_tot[Dec(serie)] + vtotalpts
//	end if
//next

for r = 1 to UpperBound(resto,1) // recorremos las series
	if Not IsNull(cant_tot[r]) and cant_tot[r] <> 0 then
		conta = data.RowCount()
		pos = data.InsertRow(conta+1)
		data1.InsertRow(conta+1)
		f_condiciones(data,pos)
		f_condiciones(data1,pos)
		
		data.SetItem (pos,"empresa",codigo_empresa)
		data.SetItem (pos,"articulo","Z")			
		data.SetItem (pos,"familia","Z")					
		data.SetItem (pos,"formato","Z")					
		data.SetItem (pos,"nombre_articulo","ZZZ(Resto)")
		data.SetItem (pos,"serie",String(r,"#"))
		data.SetItem(pos,"cantidad",resto[r])
		
		data1.SetItem (pos,"empresa",codigo_empresa)
		data1.SetItem (pos,"articulo","Z")			
		data1.SetItem (pos,"familia","Z")					
		data1.SetItem (pos,"formato","Z")					
		data1.SetItem (pos,"nombre_articulo","ZZZ(Resto)")
		data1.SetItem (pos,"serie",String(r,"#"))
		data1.SetItem(pos,"cantidad",resto[r])

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

Destroy d

end subroutine

on w_con_resumen_vtas_meses_modelos.create
int iCurrent
call super::create
this.gb_20=create gb_20
this.gb_6=create gb_6
this.gb_9=create gb_9
this.gb_3=create gb_3
this.gb_1=create gb_1
this.em_anyo=create em_anyo
this.lbx_comparacion=create lbx_comparacion
this.em_cantidad=create em_cantidad
this.uo_serie=create uo_serie
this.gb_4=create gb_4
this.rb_um=create rb_um
this.rb_piezas=create rb_piezas
this.rb_m2=create rb_m2
this.rb_ml=create rb_ml
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.dw_detalle_cliente=create dw_detalle_cliente
this.dw_listado_clientes=create dw_listado_clientes
this.uo_calidad=create uo_calidad
this.gb_5=create gb_5
this.uo_familia=create uo_familia
this.gb_7=create gb_7
this.uo_formato=create uo_formato
this.gb_8=create gb_8
this.em_tono=create em_tono
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_1=create st_1
this.gb_10=create gb_10
this.cbx_otra=create cbx_otra
this.cb_2=create cb_2
this.cbx_conjunta=create cbx_conjunta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_20
this.Control[iCurrent+2]=this.gb_6
this.Control[iCurrent+3]=this.gb_9
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.em_anyo
this.Control[iCurrent+7]=this.lbx_comparacion
this.Control[iCurrent+8]=this.em_cantidad
this.Control[iCurrent+9]=this.uo_serie
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.rb_um
this.Control[iCurrent+12]=this.rb_piezas
this.Control[iCurrent+13]=this.rb_m2
this.Control[iCurrent+14]=this.rb_ml
this.Control[iCurrent+15]=this.pb_1
this.Control[iCurrent+16]=this.pb_2
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.dw_detalle_cliente
this.Control[iCurrent+19]=this.dw_listado_clientes
this.Control[iCurrent+20]=this.uo_calidad
this.Control[iCurrent+21]=this.gb_5
this.Control[iCurrent+22]=this.uo_familia
this.Control[iCurrent+23]=this.gb_7
this.Control[iCurrent+24]=this.uo_formato
this.Control[iCurrent+25]=this.gb_8
this.Control[iCurrent+26]=this.em_tono
this.Control[iCurrent+27]=this.em_desde
this.Control[iCurrent+28]=this.em_hasta
this.Control[iCurrent+29]=this.st_1
this.Control[iCurrent+30]=this.gb_10
this.Control[iCurrent+31]=this.cbx_otra
this.Control[iCurrent+32]=this.cb_2
this.Control[iCurrent+33]=this.cbx_conjunta
end on

on w_con_resumen_vtas_meses_modelos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_20)
destroy(this.gb_6)
destroy(this.gb_9)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.em_anyo)
destroy(this.lbx_comparacion)
destroy(this.em_cantidad)
destroy(this.uo_serie)
destroy(this.gb_4)
destroy(this.rb_um)
destroy(this.rb_piezas)
destroy(this.rb_m2)
destroy(this.rb_ml)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.dw_detalle_cliente)
destroy(this.dw_listado_clientes)
destroy(this.uo_calidad)
destroy(this.gb_5)
destroy(this.uo_familia)
destroy(this.gb_7)
destroy(this.uo_formato)
destroy(this.gb_8)
destroy(this.em_tono)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_1)
destroy(this.gb_10)
destroy(this.cbx_otra)
destroy(this.cb_2)
destroy(this.cbx_conjunta)
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Resumen ventas Artículos "
This.title=istr_parametros.s_titulo_ventana

em_anyo.text = String(year(Today()))
lbx_comparacion.text = ">"
dw_detalle_cliente.SetTransObject(SQLCA)
dw_listado_clientes.SetTransObject(SQLCA)

cbx_otra.text = "Ver "+f_nombre_empresa(f_mercaderia_empresa(codigo_empresa))

f_activar_campo(em_anyo)

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_meses_modelos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_meses_modelos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_meses_modelos
end type

type gb_20 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 2322
integer y = 312
integer width = 389
integer height = 204
integer taborder = 200
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
end type

type gb_6 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 1787
integer y = 120
integer width = 759
integer height = 192
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
end type

type gb_9 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 1102
integer y = 340
integer width = 261
integer height = 176
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Tono"
end type

type gb_3 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 951
integer y = 164
integer width = 549
integer height = 176
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

type gb_1 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 27
integer y = 160
integer width = 320
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

type em_anyo from u_em_campo within w_con_resumen_vtas_meses_modelos
integer x = 73
integer y = 232
integer width = 238
integer taborder = 20
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###"
end type

type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_modelos
integer x = 987
integer y = 228
integer width = 192
integer height = 224
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {">","<",">=","<=","<>","="}
borderstyle borderstyle = stylelowered!
end type

type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_modelos
integer x = 1198
integer y = 232
integer width = 270
integer height = 80
integer taborder = 60
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
end type

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
event destroy ( )
integer x = 393
integer y = 232
integer width = 526
integer taborder = 30
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

type gb_4 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 361
integer y = 164
integer width = 590
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

type rb_um from radiobutton within w_con_resumen_vtas_meses_modelos
integer x = 1815
integer y = 160
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
string text = "miles de u.m."
boolean checked = true
end type

type rb_piezas from radiobutton within w_con_resumen_vtas_meses_modelos
integer x = 1815
integer y = 228
integer width = 475
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
string text = "piezas"
end type

type rb_m2 from radiobutton within w_con_resumen_vtas_meses_modelos
integer x = 2345
integer y = 160
integer width = 183
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
string text = "m2"
end type

type rb_ml from radiobutton within w_con_resumen_vtas_meses_modelos
integer x = 2345
integer y = 228
integer width = 174
integer height = 76
integer taborder = 160
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

type pb_1 from upb_salir within w_con_resumen_vtas_meses_modelos
integer x = 2606
integer y = 16
integer width = 110
integer height = 96
integer taborder = 200
boolean bringtotop = true
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_modelos
integer x = 2606
integer y = 160
integer taborder = 180
boolean bringtotop = true
boolean originalsize = false
string picturename = "print!"
end type

event clicked;//// esto va un poco lento... preguntar a Nuria por qué
////dw_listado_clientes.Object.Data = dw_detalle_cliente.Object.Data
//
//if rb_um.checked then
//	f_cargar_um(dw_listado_clientes)
//else
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
//f_imprimir_datawindow(dw_listado_clientes)
//
//
if dw_detalle_cliente.rowcount() >0 then
	f_imprimir_datawindow(dw_listado_clientes)
else
	cb_1.triggerevent(clicked!)
	f_imprimir_datawindow(dw_listado_clientes)
end if
end event

type cb_1 from u_boton within w_con_resumen_vtas_meses_modelos
integer x = 1961
integer y = 344
integer width = 352
integer height = 84
integer taborder = 170
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;// campos obligatorios
if rb_um.checked then
	f_cargar_um(dw_detalle_cliente,dw_listado_clientes)
else
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

type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_modelos
integer x = 32
integer y = 540
integer width = 2688
integer height = 928
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_resumen_vtas_meses_modelos"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;choose case f_objeto_datawindow(this)
	case "articulo_t"	
		this.setsort("serie A,familia A,formato A,nombre_articulo A,tono A")
		dw_listado_clientes.setsort("serie A,familia A,formato A,nombre_articulo A, tono A")		
	case "cantidad_t" 
		this.setsort("serie A,familia A,formato A,cantidad D")
		dw_listado_clientes.setsort("serie A,familia A,formato A,cantidad D")
	case else
end choose
this.Sort()
dw_listado_clientes.Sort()
this.GroupCalc()
dw_listado_clientes.GroupCalc()
end event

type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_modelos
boolean visible = false
integer x = 178
integer y = 668
integer width = 937
integer height = 464
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_con_resumen_vtas_meses_modelos"
end type

type uo_calidad from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
event destroy ( )
integer x = 1536
integer y = 232
integer width = 206
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)

If Trim(uo_calidad.em_campo.text)="" then
	uo_calidad.em_campo.text=""
	uo_calidad.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Calidades"
	ue_datawindow ="dw_ayuda_calidades"
	ue_filtro = ""

end event

type gb_5 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 1504
integer y = 164
integer width = 279
integer height = 176
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Calidad"
end type

type uo_familia from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
event destroy ( )
integer x = 59
integer y = 408
integer width = 526
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_familia.em_campo.text=f_nombre_familia(codigo_empresa,uo_familia.em_codigo.text)

If Trim(uo_familia.em_campo.text)="" then
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Familias"
	ue_datawindow ="dw_ayuda_familias"
	ue_filtro = ""

end event

type gb_7 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 27
integer y = 340
integer width = 590
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Familia"
end type

type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_modelos
event destroy ( )
integer x = 654
integer y = 408
integer width = 411
integer taborder = 90
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Formatos"
	ue_datawindow ="dw_ayuda_formatos"
	ue_filtro = ""

end event

type gb_8 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 622
integer y = 340
integer width = 475
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

type em_tono from u_em_campo within w_con_resumen_vtas_meses_modelos
integer x = 1129
integer y = 408
integer width = 206
integer taborder = 100
boolean bringtotop = true
string mask = "xxxx"
end type

type em_desde from u_em_campo within w_con_resumen_vtas_meses_modelos
integer x = 1449
integer y = 408
integer width = 187
integer taborder = 110
boolean bringtotop = true
end type

event modificado;call super::modificado;em_hasta.text = em_desde.text
end event

type em_hasta from u_em_campo within w_con_resumen_vtas_meses_modelos
integer x = 1728
integer y = 408
integer width = 187
integer taborder = 120
boolean bringtotop = true
end type

type st_1 from statictext within w_con_resumen_vtas_meses_modelos
integer x = 1655
integer y = 408
integer width = 50
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_10 from groupbox within w_con_resumen_vtas_meses_modelos
integer x = 1367
integer y = 344
integer width = 585
integer height = 172
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 79741120
string text = "Iniciales"
end type

type cbx_otra from checkbox within w_con_resumen_vtas_meses_modelos
integer x = 2341
integer y = 352
integer width = 357
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

type cb_2 from commandbutton within w_con_resumen_vtas_meses_modelos
integer x = 1961
integer y = 432
integer width = 352
integer height = 84
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

type cbx_conjunta from checkbox within w_con_resumen_vtas_meses_modelos
integer x = 2345
integer y = 432
integer width = 329
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

