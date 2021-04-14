$PBExportHeader$w_con_resumen_vtas_meses_articulos2.srw
forward
global type w_con_resumen_vtas_meses_articulos2 from w_int_con_empresa
end type
type gb_2 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type gb_9 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type gb_3 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type gb_1 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type em_anyo from u_em_campo within w_con_resumen_vtas_meses_articulos2
end type
type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_articulos2
end type
type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_articulos2
end type
type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
end type
type gb_4 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type rb_um from radiobutton within w_con_resumen_vtas_meses_articulos2
end type
type rb_piezas from radiobutton within w_con_resumen_vtas_meses_articulos2
end type
type rb_m2 from radiobutton within w_con_resumen_vtas_meses_articulos2
end type
type rb_ml from radiobutton within w_con_resumen_vtas_meses_articulos2
end type
type pb_1 from upb_salir within w_con_resumen_vtas_meses_articulos2
end type
type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_articulos2
end type
type cb_1 from u_boton within w_con_resumen_vtas_meses_articulos2
end type
type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_articulos2
end type
type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_articulos2
end type
type uo_familia from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
end type
type gb_7 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
end type
type gb_8 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type em_tono from u_em_campo within w_con_resumen_vtas_meses_articulos2
end type
type em_desde from u_em_campo within w_con_resumen_vtas_meses_articulos2
end type
type em_hasta from u_em_campo within w_con_resumen_vtas_meses_articulos2
end type
type st_1 from statictext within w_con_resumen_vtas_meses_articulos2
end type
type gb_10 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type cbx_otra from checkbox within w_con_resumen_vtas_meses_articulos2
end type
type cb_2 from commandbutton within w_con_resumen_vtas_meses_articulos2
end type
type cbx_conjunta from checkbox within w_con_resumen_vtas_meses_articulos2
end type
type uo_mes1 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
end type
type uo_mes2 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
end type
type gb_5 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type uo_calidad from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
end type
type gb_20 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type gb_6 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type gb_50 from groupbox within w_con_resumen_vtas_meses_articulos2
end type
type r_1 from rectangle within w_con_resumen_vtas_meses_articulos2
end type
type rb_serie from checkbox within w_con_resumen_vtas_meses_articulos2
end type
end forward

global type w_con_resumen_vtas_meses_articulos2 from w_int_con_empresa
integer width = 2802
integer height = 1676
gb_2 gb_2
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
uo_mes1 uo_mes1
uo_mes2 uo_mes2
gb_5 gb_5
uo_calidad uo_calidad
gb_20 gb_20
gb_6 gb_6
gb_50 gb_50
r_1 r_1
rb_serie rb_serie
end type
global w_con_resumen_vtas_meses_articulos2 w_con_resumen_vtas_meses_articulos2

type variables
boolean detalle = false
String otra_empresa
end variables

forward prototypes
public subroutine f_condiciones (datawindow data, integer row)
public subroutine f_cargar_cantidad (datawindow data, string unidad, datawindow data1)
public subroutine f_cargar_um (datawindow data, datawindow data1)
public subroutine f_campos_segun_meses (datawindow data)
end prototypes

public subroutine f_condiciones (datawindow data, integer row);String condic1 = "",condic2=""

condic1 = "Año: " + em_anyo.text+" "


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

end subroutine

public subroutine f_cargar_cantidad (datawindow data, string unidad, datawindow data1);String Sel,moneda,nombre_moneda,serie1,serie2,empresa,&
		serie,vart,uni,cal1,cal2,to1,to2,ini1,ini2,&
		fam1,fam2,form1,form2,fam,form,cal,tono,nombre_articulo,&
		nom_fam, nom_form,restriccion,filtro,cliente,vref
Dec  cantidad,mov,vtotal,vcant,por,tot,t,cant
Integer r,s,c,cc,i,conta
real cant_resto[10,12]
long pos,indice1,total1
string nombre_mes
int mes

DataStore d
datastore meses

for c=1 to 10
	for cc = 1 to 12
		cant_resto[c,cc] = 0
	next
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
	ini2 = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
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
Sel = " SELECT empresa,serie,cliente,referencia,articulo" +&      
		" FROM   venlifac " +&
      " WHERE  venlifac.empresa like '"+empresa+"'" +&
      " And    venlifac.serie between '"+serie1+"' and '"+serie2+"' "+&
      " And    venlifac.familia between '"+fam1+"' and '"+fam2+"' "+&
      " And    venlifac.formato between '"+form1+"' and '"+form2+"' "+&		
      " And    venlifac.descripcion between '"+ini1+"' and '"+ini2+"' "+&		
      " And    venlifac.calidad between '"+cal1+"' and '"+cal2+"' "+&		
      " And    venlifac.tonochar between '"+to1+"' and '"+to2+"' "+&				
      " And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
		" and 	venlifac.mes between "+uo_mes1.em_codigo.text+" and "+uo_mes2.em_codigo.text+&
		restriccion+&
		" GROUP By empresa,serie,cliente,referencia,articulo"+ &
		" Order By empresa,serie,cliente,referencia,articulo"

//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

dec resul = 0

c = 0
tot =  0
otra_empresa = f_mercaderia_empresa(codigo_empresa)

For r = 1 To d.RowCOunt()
		
	serie    = d.GetItemString(r,"serie")
	vart  = d.GetItemString(r,"articulo")
	vref  = d.GetItemString(r,"referencia")
	cliente  = d.GetItemString(r,"cliente")
	
	sel = "select mes,sum(cantidad) cantidad from venlifac "+&
			" WHERE  venlifac.empresa like '"+empresa+"'" +&
			" And    venlifac.calidad between '"+cal1+"' and '"+cal2+"' "+&		
  			" And    venlifac.tonochar between '"+to1+"' and '"+to2+"' "+&				
	   	" And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
			" and 	venlifac.referencia ='"+vref+"' "+&
			" and 	venlifac.cliente ='"+cliente+"' "+&
			" and 	venlifac.mes between "+uo_mes1.em_codigo.text+" and "+uo_mes2.em_codigo.text+&
			" GROUP By mes "+ &
			" Order By mes"

//	meses = f_cargar_cursor (sel)
	f_Cargar_cursor_nuevo(sel, meses)
			
	serie   = d.GetItemString(r,"serie")
	nombre_articulo = f_nombre_articulo(codigo_empresa,vart)
	fam   = f_familia_articulo (codigo_empresa,vart)
	nom_fam = f_nombre_familia(codigo_empresa,fam)
	form  = f_formato_articulo(codigo_empresa,vart)
	nom_form = f_nombre_formato_abr(codigo_empresa,form)	
	if rb_serie.checked then
		serie = "10"
	end if
	
	if not (cbx_conjunta.checked and &
			(empresa = codigo_empresa and &
			cliente = trim(f_cliente_mercaderia(codigo_empresa)))  or &
			(empresa = otra_empresa and &
			cliente = trim(f_cliente_mercaderia(otra_empresa)))) then
		
		resul = data.find ("articulo ='"+vart+"' and serie ='"+serie+"'",1,data.rowcount())
		if resul = 0 then
			
			c = c +1
			pos=data.InsertRow(c)
			data1.InsertRow(c)
			
			f_condiciones(data1,pos)
			
			data.SetItem(pos,"empresa",empresa)
			data.SetItem(pos,"articulo",vart)
			data.SetItem(pos,"nombre_articulo",nombre_articulo)
			data.SetItem(pos,"familia",fam)
			data.SetItem(pos,"formato",form)
			data.SetItem(pos,"fam_form",nom_fam+" "+nom_form)	
			data.SetItem(pos,"serie",serie)
			data.SetItem(pos,"unidad",unidad)			
		
			data1.SetItem(pos,"empresa",empresa)
			data1.SetItem(pos,"articulo",vart)
			data1.SetItem(pos,"nombre_articulo",nombre_articulo)
			data1.SetItem(pos,"familia",fam)
			data1.SetItem(pos,"formato",form)
			data1.SetItem(pos,"fam_form",nom_fam+" "+nom_form)	
			data1.SetItem(pos,"serie",serie)
			data1.SetItem(pos,"unidad",unidad)			
			
			total1 = meses.rowcount()
			
			if total1 > 0 then
				for indice1 = 1 to total1
					mes = meses.getitemnumber(indice1,"mes")
					cantidad = meses.getitemdecimal(indice1,"cantidad")
					nombre_mes = "mes"+string(mes - dec(uo_mes1.em_codigo.text) +1)
					
					choose case unidad
						case "piezas" // unidad de la estadística: piezas
							// convertimos de m2 o piezas --> piezas
							cantidad = f_conversion_cantidad_piezas_old(codigo_empresa,vart,cantidad)
						case  "m2"    // unidad de la estadística --> metros cuadrados
							cantidad = f_conversion_cantidad_m2(codigo_empresa,vart,cantidad)
							
						case  "ml"    // unidad de la estadística --> metros lineales
							cantidad = f_conversion_cantidad_ml(codigo_empresa,vart,cantidad)			
							
					end choose
					if IsNull(cantidad) then cantidad = 0
					data.SetItem(pos,nombre_mes,cantidad)
					data1.SetItem(pos,nombre_mes,cantidad)
				next
			end if
			f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
		else
			total1 = meses.rowcount()
			if total1 > 0 then
				for indice1 = 1 to total1
					mes = meses.getitemnumber(indice1,"mes")
					
					cantidad = meses.getitemdecimal(indice1,"cantidad")
					nombre_mes = "mes"+string(mes - dec(uo_mes1.em_codigo.text) +1)
					
					choose case unidad
						case "piezas" // unidad de la estadística: piezas
							// convertimos de m2 o piezas --> piezas
							cantidad = f_conversion_cantidad_piezas_old(codigo_empresa,vart,cantidad)
							
						case  "m2"    // unidad de la estadística --> metros cuadrados
							cantidad = f_conversion_cantidad_m2(codigo_empresa,vart,cantidad)
							
						case  "ml"    // unidad de la estadística --> metros lineales
							cantidad = f_conversion_cantidad_ml(codigo_empresa,vart,cantidad)			
							
					end choose
					if IsNull(cantidad) then cantidad = 0
					cantidad = cantidad + data.getitemdecimal(resul,nombre_mes)
					data.SetItem(resul,nombre_mes,cantidad)
					data1.SetItem(resul,nombre_mes,cantidad)
				next
			end if
			f_mensaje_proceso("Leyendo facturas",r,d.RowCount())			
		end if
	end if // del super if
Next
total1 = data.rowcount()
real total_articulo
indice1 = total1
do while indice1 >= 1
	f_mensaje_proceso("Filtrando Articulos",indice1,total1)
	total_articulo = data.getitemnumber(indice1,"total")
	serie = data.getitemstring(indice1,"serie")
	resul = 0
	
	choose case lbx_comparacion.text
		case ">"
			if total_articulo > Dec(em_cantidad.text) then resul =1
		case "<"
			if total_articulo < Dec(em_cantidad.text) then resul =1
		case ">="
			if total_articulo >= Dec(em_cantidad.text) then resul =1
		case "<="
			if total_articulo <= Dec(em_cantidad.text) then resul =1
		case "<>"
			if total_articulo <> Dec(em_cantidad.text) then resul =1
		case "="
			if total_articulo = Dec(em_cantidad.text) then resul =1
	end choose		
		if resul = 0 then
			for cc = 1 to 12
				nombre_mes = "mes"+string(cc)
				vcant = data.getitemnumber(indice1,nombre_mes)
				cant_resto[Dec(serie),cc] = cant_resto[Dec(serie),cc] + vcant
			next
			data.deleterow(indice1)
			data1.deleterow(indice1)
		end if
	indice1 = indice1 -1 
loop
for r = 1 to 10 // recorremos las serie
	for cc = 1 to 12
		f_mensaje_proceso("Insertando resto",r*cc,120)
		if Not IsNull(cant_resto[r,cc]) and cant_resto[r,cc] <> 0 then
			conta = data.RowCount()
			nombre_mes = "mes"+string(cc)
			
			data.InsertRow(conta+1)
			data.SetItem (conta+1,"empresa",codigo_empresa)
			data.SetItem (conta+1,"articulo","Z")			
			data.SetItem (conta+1,"nombre_articulo","ZZZResto")
			data.SetItem (conta+1,"fam_form","ZZZResto")
			data.SetItem (conta+1,"familia","Z")
			data.SetItem (conta+1,"formato","Z")		
			data.SetItem (conta+1,"serie",String(r,"#"))
			data.SetItem(conta+1,nombre_mes,cant_resto[r,cc])
			data.SetItem(pos,"unidad",unidad)	
			
			data1.InsertRow(conta+1)
			data1.SetItem (conta+1,"empresa",codigo_empresa)
			data1.SetItem (conta+1,"articulo","Z")			
			data1.SetItem (conta+1,"nombre_articulo","ZZZResto")
			data1.SetItem (conta+1,"fam_form","ZZZResto")
			data1.SetItem (conta+1,"familia","Z")
			data1.SetItem (conta+1,"formato","Z")		
			data1.SetItem (conta+1,"serie",String(r,"#"))
			data1.SetItem(conta+1,nombre_mes,cant_resto[r,cc])
			data1.SetItem(pos,"unidad",unidad)	
			f_condiciones(data1,conta+1)
		end if
	next
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
destroy meses
	
	//	f_mensaje("lbx_comparacion.text",lbx_comparacion.text)
		

end subroutine

public subroutine f_cargar_um (datawindow data, datawindow data1);String Sel,moneda,nombre_moneda,serie1,serie2,empresa,&
		serie,vart,uni,cal1,cal2,to1,to2,ini1,ini2,&
		fam1,fam2,form1,form2,fam,form,cal,tono,nombre_articulo,&
		nom_fam, nom_form,restriccion,filtro,cliente,vref
Dec  cantidad,mov,vtotal,vcant,por,tot,t,cant
Integer r,s,c,cc,i,conta
real cant_resto[10,12]
long pos,indice1,total1
string nombre_mes
int mes

DataStore d
datastore meses

for c=1 to 10
	for cc = 1 to 12
		cant_resto[c,cc] = 0
	next
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
	ini2 = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
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
Sel = " SELECT empresa,serie,cliente,referencia,articulo" +&      
		" FROM   venlifac " +&
      " WHERE  venlifac.empresa like '"+empresa+"'" +&
      " And    venlifac.serie between '"+serie1+"' and '"+serie2+"' "+&
      " And    venlifac.familia between '"+fam1+"' and '"+fam2+"' "+&
      " And    venlifac.formato between '"+form1+"' and '"+form2+"' "+&		
      " And    venlifac.descripcion between '"+ini1+"' and '"+ini2+"' "+&		
      " And    venlifac.calidad between '"+cal1+"' and '"+cal2+"' "+&		
      " And    venlifac.tonochar between '"+to1+"' and '"+to2+"' "+&				
      " And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
		" and 	venlifac.mes between "+uo_mes1.em_codigo.text+" and "+uo_mes2.em_codigo.text+&
		restriccion+&
		" GROUP By empresa,serie,cliente,referencia,articulo"+ &
		" Order By empresa,serie,cliente,referencia,articulo"

//d= f_cargar_cursor(sel)
f_Cargar_cursor_nuevo(sel, d)

dec resul = 0

c = 0
tot =  0
otra_empresa = f_mercaderia_empresa(codigo_empresa)

For r = 1 To d.RowCOunt()
		
	serie    = d.GetItemString(r,"serie")
	vart  = d.GetItemString(r,"articulo")
	vref  = d.GetItemString(r,"referencia")
	cliente = d.GetItemString(r,"cliente")
	
	sel = "select mes,Sum((neto - impdtopp) * cambio) cantidad from venlifac "+&
			" WHERE  venlifac.empresa like '"+empresa+"'" +&
			" And    venlifac.calidad between '"+cal1+"' and '"+cal2+"' "+&		
  			" And    venlifac.tonochar between '"+to1+"' and '"+to2+"' "+&				
	   	" And    venlifac.anyo = "+String(Dec(em_anyo.text),"####")+&
			" and 	venlifac.cliente ='"+cliente+"' "+&
			" and 	venlifac.referencia ='"+vref+"' "+&
			" and 	venlifac.mes between "+uo_mes1.em_codigo.text+" and "+uo_mes2.em_codigo.text+&
			" GROUP By mes "+ &
			" Order By mes"

//	meses = f_cargar_cursor (sel)
	f_Cargar_cursor_nuevo(sel, meses)
			
	serie   = d.GetItemString(r,"serie")
	nombre_articulo = f_nombre_articulo(codigo_empresa,vart)
	fam   = f_familia_articulo (codigo_empresa,vart)
	nom_fam = f_nombre_familia(codigo_empresa,fam)
	form  = f_formato_articulo(codigo_empresa,vart)
	nom_form = f_nombre_formato_abr(codigo_empresa,form)
	if rb_serie.checked then
		serie = "10"
	end if	
	
	if not (cbx_conjunta.checked and &
			(empresa = codigo_empresa and &
			cliente = trim(f_cliente_mercaderia(codigo_empresa)))  or &
			(empresa = otra_empresa and &
			cliente = trim(f_cliente_mercaderia(otra_empresa)))) then
		
		resul = data.find ("articulo ='"+vart+"' and serie ='"+serie+"'",1,data.rowcount())
		if resul = 0 then
			
			c = c +1
			pos=data.InsertRow(c)
			data1.InsertRow(c)
			
			f_condiciones(data1,pos)
	
			data.SetItem(pos,"empresa",empresa)
			data.SetItem(pos,"articulo",vart)
			data.SetItem(pos,"nombre_articulo",nombre_articulo)
			data.SetItem(pos,"familia",fam)
			data.SetItem(pos,"formato",form)
			data.SetItem(pos,"fam_form",nom_fam+" "+nom_form)	
			data.SetItem(pos,"serie",serie)
			data.SetItem(pos,"unidad","Miles de u.m.")			
		
			data1.SetItem(pos,"empresa",empresa)
			data1.SetItem(pos,"articulo",vart)
			data1.SetItem(pos,"nombre_articulo",nombre_articulo)
			data1.SetItem(pos,"familia",fam)
			data1.SetItem(pos,"formato",form)
			data1.SetItem(pos,"fam_form",nom_fam+" "+nom_form)	
			data1.SetItem(pos,"serie",serie)
			data1.SetItem(pos,"unidad","Miles de u.m.")			
			
			total1 = meses.rowcount()
			
			if total1 > 0 then
				for indice1 = 1 to total1
					mes = meses.getitemnumber(indice1,"mes")
					cantidad = (meses.getitemdecimal(indice1,"cantidad"))/1000
					nombre_mes = "mes"+string(mes - dec(uo_mes1.em_codigo.text) +1)
					
					if IsNull(cantidad) then cantidad = 0
					data.SetItem(pos,nombre_mes,cantidad)
					data1.SetItem(pos,nombre_mes,cantidad)
				next
			end if
			f_mensaje_proceso("Leyendo facturas",r,d.RowCount())
		else
			total1 = meses.rowcount()
			if total1 > 0 then
				for indice1 = 1 to total1
					mes = meses.getitemnumber(indice1,"mes")
					
					cantidad = (meses.getitemdecimal(indice1,"cantidad"))/1000
					nombre_mes = "mes"+string(mes - dec(uo_mes1.em_codigo.text) +1)
					if IsNull(cantidad) then cantidad = 0
					cantidad = cantidad + data.getitemdecimal(resul,nombre_mes)
					data.SetItem(resul,nombre_mes,cantidad)
					data1.SetItem(resul,nombre_mes,cantidad)
				next
			end if
			f_mensaje_proceso("Leyendo facturas",r,d.RowCount())			
		end if
	end if // del super if
Next
total1 = data.rowcount()
real total_articulo
indice1 = total1
do while indice1 >= 1
	f_mensaje_proceso("Filtrando Articulos",indice1,total1)
	total_articulo = data.getitemnumber(indice1,"total")
	serie = data.getitemstring(indice1,"serie")
	resul = 0
	
	choose case lbx_comparacion.text
		case ">"
			if total_articulo > Dec(em_cantidad.text) then resul =1
		case "<"
			if total_articulo < Dec(em_cantidad.text) then resul =1
		case ">="
			if total_articulo >= Dec(em_cantidad.text) then resul =1
		case "<="
			if total_articulo <= Dec(em_cantidad.text) then resul =1
		case "<>"
			if total_articulo <> Dec(em_cantidad.text) then resul =1
		case "="
			if total_articulo = Dec(em_cantidad.text) then resul =1
	end choose		
		if resul = 0 then
			for cc = 1 to 12
				nombre_mes = "mes"+string(cc)
				vcant = data.getitemnumber(indice1,nombre_mes)
				cant_resto[Dec(serie),cc] = cant_resto[Dec(serie),cc] + vcant
			next
			data.deleterow(indice1)
			data1.deleterow(indice1)
		end if
	indice1 = indice1 -1 
loop
for r = 1 to 10 // recorremos las serie
	for cc = 1 to 12
		f_mensaje_proceso("Insertando resto",r*cc,120)
		if Not IsNull(cant_resto[r,cc]) and cant_resto[r,cc] <> 0 then
			conta = data.RowCount()
			nombre_mes = "mes"+string(cc)
			
			data.InsertRow(conta+1)
			data.SetItem (conta+1,"empresa",codigo_empresa)
			data.SetItem (conta+1,"articulo","Z")			
			data.SetItem (conta+1,"nombre_articulo","ZZZResto")
			data.SetItem (conta+1,"fam_form","ZZZResto")
			data.SetItem (conta+1,"familia","Z")
			data.SetItem (conta+1,"formato","Z")		
			data.SetItem (conta+1,"serie",String(r,"#"))
			data.SetItem(conta+1,nombre_mes,cant_resto[r,cc])
			data.SetItem(pos,"unidad","Miles de u.m.")			
			
			data1.InsertRow(conta+1)
			data1.SetItem (conta+1,"empresa",codigo_empresa)
			data1.SetItem (conta+1,"articulo","Z")			
			data1.SetItem (conta+1,"nombre_articulo","ZZZResto")
			data1.SetItem (conta+1,"fam_form","ZZZResto")
			data1.SetItem (conta+1,"familia","Z")
			data1.SetItem (conta+1,"formato","Z")		
			data1.SetItem (conta+1,"serie",String(r,"#"))
			data1.SetItem(conta+1,nombre_mes,cant_resto[r,cc])
			data1.SetItem(pos,"unidad","Miles de u.m.")			
			f_condiciones(data1,conta+1)
		end if
	next
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
destroy meses
	
	//	f_mensaje("lbx_comparacion.text",lbx_comparacion.text)
		

end subroutine

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

on w_con_resumen_vtas_meses_articulos2.create
int iCurrent
call super::create
this.gb_2=create gb_2
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
this.uo_mes1=create uo_mes1
this.uo_mes2=create uo_mes2
this.gb_5=create gb_5
this.uo_calidad=create uo_calidad
this.gb_20=create gb_20
this.gb_6=create gb_6
this.gb_50=create gb_50
this.r_1=create r_1
this.rb_serie=create rb_serie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_9
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.em_anyo
this.Control[iCurrent+6]=this.lbx_comparacion
this.Control[iCurrent+7]=this.em_cantidad
this.Control[iCurrent+8]=this.uo_serie
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.rb_um
this.Control[iCurrent+11]=this.rb_piezas
this.Control[iCurrent+12]=this.rb_m2
this.Control[iCurrent+13]=this.rb_ml
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.pb_2
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.dw_detalle_cliente
this.Control[iCurrent+18]=this.dw_listado_clientes
this.Control[iCurrent+19]=this.uo_familia
this.Control[iCurrent+20]=this.gb_7
this.Control[iCurrent+21]=this.uo_formato
this.Control[iCurrent+22]=this.gb_8
this.Control[iCurrent+23]=this.em_tono
this.Control[iCurrent+24]=this.em_desde
this.Control[iCurrent+25]=this.em_hasta
this.Control[iCurrent+26]=this.st_1
this.Control[iCurrent+27]=this.gb_10
this.Control[iCurrent+28]=this.cbx_otra
this.Control[iCurrent+29]=this.cb_2
this.Control[iCurrent+30]=this.cbx_conjunta
this.Control[iCurrent+31]=this.uo_mes1
this.Control[iCurrent+32]=this.uo_mes2
this.Control[iCurrent+33]=this.gb_5
this.Control[iCurrent+34]=this.uo_calidad
this.Control[iCurrent+35]=this.gb_20
this.Control[iCurrent+36]=this.gb_6
this.Control[iCurrent+37]=this.gb_50
this.Control[iCurrent+38]=this.r_1
this.Control[iCurrent+39]=this.rb_serie
end on

on w_con_resumen_vtas_meses_articulos2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
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
destroy(this.uo_mes1)
destroy(this.uo_mes2)
destroy(this.gb_5)
destroy(this.uo_calidad)
destroy(this.gb_20)
destroy(this.gb_6)
destroy(this.gb_50)
destroy(this.r_1)
destroy(this.rb_serie)
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

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_resumen_vtas_meses_articulos2
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_resumen_vtas_meses_articulos2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_resumen_vtas_meses_articulos2
end type

type gb_2 from groupbox within w_con_resumen_vtas_meses_articulos2
integer x = 347
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

type gb_9 from groupbox within w_con_resumen_vtas_meses_articulos2
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

type gb_3 from groupbox within w_con_resumen_vtas_meses_articulos2
integer x = 1637
integer y = 160
integer width = 549
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

type gb_1 from groupbox within w_con_resumen_vtas_meses_articulos2
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

type em_anyo from u_em_campo within w_con_resumen_vtas_meses_articulos2
integer x = 73
integer y = 232
integer width = 238
integer taborder = 20
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#,###"
end type

type lbx_comparacion from dropdownlistbox within w_con_resumen_vtas_meses_articulos2
integer x = 1673
integer y = 224
integer width = 192
integer height = 228
integer taborder = 60
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

type em_cantidad from u_em_campo within w_con_resumen_vtas_meses_articulos2
integer x = 1883
integer y = 228
integer width = 270
integer taborder = 80
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,##0"
end type

type uo_serie from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
event destroy ( )
integer x = 1079
integer y = 228
integer width = 526
integer height = 88
integer taborder = 50
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

type gb_4 from groupbox within w_con_resumen_vtas_meses_articulos2
integer x = 1047
integer y = 160
integer width = 590
integer height = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Serie"
end type

type rb_um from radiobutton within w_con_resumen_vtas_meses_articulos2
integer x = 59
integer y = 532
integer width = 475
integer height = 64
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
string text = "miles de u.m."
boolean checked = true
end type

type rb_piezas from radiobutton within w_con_resumen_vtas_meses_articulos2
integer x = 553
integer y = 532
integer width = 475
integer height = 64
integer taborder = 170
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

type rb_m2 from radiobutton within w_con_resumen_vtas_meses_articulos2
integer x = 873
integer y = 532
integer width = 183
integer height = 64
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
string text = "m2"
end type

type rb_ml from radiobutton within w_con_resumen_vtas_meses_articulos2
integer x = 1074
integer y = 532
integer width = 174
integer height = 64
integer taborder = 180
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

type pb_1 from upb_salir within w_con_resumen_vtas_meses_articulos2
integer x = 2569
integer y = 8
integer width = 110
integer height = 96
integer taborder = 240
boolean bringtotop = true
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_resumen_vtas_meses_articulos2
integer x = 2569
integer y = 152
integer taborder = 200
boolean bringtotop = true
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

type cb_1 from u_boton within w_con_resumen_vtas_meses_articulos2
integer x = 1961
integer y = 344
integer width = 352
integer height = 84
integer taborder = 190
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

type dw_detalle_cliente from u_datawindow_consultas within w_con_resumen_vtas_meses_articulos2
integer x = 23
integer y = 604
integer width = 2688
integer height = 856
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_resumen_vtas_meses_articulos"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;call super::clicked;choose case f_objeto_datawindow(this)
	case "articulo_t"	
		this.setsort("serie A,famform A,nombre_articulo A")
		dw_listado_clientes.setsort("serie A,famform A,nombre_articulo A")		
	case "total_t" 
		this.setsort("serie A,total_cliente_l D,total D")
		dw_listado_clientes.setsort("serie A,total_cliente_l D,total D")
	case else
end choose
this.Sort()
dw_listado_clientes.Sort()
this.GroupCalc()
dw_listado_clientes.GroupCalc()
end event

type dw_listado_clientes from u_datawindow within w_con_resumen_vtas_meses_articulos2
boolean visible = false
integer x = 73
integer y = 16
integer width = 101
integer height = 116
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_resumen_vtas_meses_articulos"
end type

type uo_familia from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
event destroy ( )
integer x = 59
integer y = 408
integer width = 526
integer taborder = 100
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

type gb_7 from groupbox within w_con_resumen_vtas_meses_articulos2
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

type uo_formato from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
event destroy ( )
integer x = 654
integer y = 408
integer width = 411
integer taborder = 110
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

type gb_8 from groupbox within w_con_resumen_vtas_meses_articulos2
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

type em_tono from u_em_campo within w_con_resumen_vtas_meses_articulos2
integer x = 1129
integer y = 408
integer width = 206
integer taborder = 120
boolean bringtotop = true
string mask = "xxxx"
end type

type em_desde from u_em_campo within w_con_resumen_vtas_meses_articulos2
integer x = 1449
integer y = 408
integer width = 187
integer taborder = 130
boolean bringtotop = true
end type

event modificado;call super::modificado;em_hasta.text = em_desde.text
end event

type em_hasta from u_em_campo within w_con_resumen_vtas_meses_articulos2
integer x = 1728
integer y = 408
integer width = 187
integer taborder = 140
boolean bringtotop = true
end type

type st_1 from statictext within w_con_resumen_vtas_meses_articulos2
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

type gb_10 from groupbox within w_con_resumen_vtas_meses_articulos2
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

type cbx_otra from checkbox within w_con_resumen_vtas_meses_articulos2
integer x = 2345
integer y = 368
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

type cb_2 from commandbutton within w_con_resumen_vtas_meses_articulos2
integer x = 1961
integer y = 432
integer width = 352
integer height = 84
integer taborder = 210
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

type cbx_conjunta from checkbox within w_con_resumen_vtas_meses_articulos2
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

type uo_mes1 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
integer x = 375
integer y = 236
integer width = 315
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_mes1.em_campo.text=f_nombre_mes(Dec(uo_mes1.em_codigo.text))
IF Trim(uo_mes1.em_campo.text)="" THEN 
 IF Trim(uo_mes1.em_codigo.text)<>"" Then uo_mes1.em_campo.SetFocus()
 uo_mes1.em_campo.text=""
 uo_mes1.em_codigo.text=""
END IF

end event

on uo_mes1.destroy
call u_em_campo_2::destroy
end on

type uo_mes2 from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
integer x = 709
integer y = 236
integer width = 315
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_mes2.em_campo.text=f_nombre_mes(Dec(uo_mes2.em_codigo.text))
IF Trim(uo_mes2.em_campo.text)="" THEN 
 IF Trim(uo_mes2.em_codigo.text)<>"" Then uo_mes2.em_campo.SetFocus()
 uo_mes2.em_campo.text=""
 uo_mes2.em_codigo.text=""
END IF
end event

on uo_mes2.destroy
call u_em_campo_2::destroy
end on

type gb_5 from groupbox within w_con_resumen_vtas_meses_articulos2
integer x = 2190
integer y = 160
integer width = 279
integer height = 180
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

type uo_calidad from u_em_campo_2 within w_con_resumen_vtas_meses_articulos2
event destroy ( )
integer x = 2222
integer y = 228
integer width = 206
integer height = 88
integer taborder = 90
boolean bringtotop = true
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

type gb_20 from groupbox within w_con_resumen_vtas_meses_articulos2
integer x = 2322
integer y = 320
integer width = 389
integer height = 196
integer taborder = 220
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
end type

type gb_6 from groupbox within w_con_resumen_vtas_meses_articulos2
integer x = 27
integer y = 488
integer width = 1253
integer height = 116
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
end type

type gb_50 from groupbox within w_con_resumen_vtas_meses_articulos2
integer x = 1952
integer y = 488
integer width = 759
integer height = 116
integer taborder = 230
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
end type

type r_1 from rectangle within w_con_resumen_vtas_meses_articulos2
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 12632256
integer x = 1280
integer y = 520
integer width = 667
integer height = 80
end type

type rb_serie from checkbox within w_con_resumen_vtas_meses_articulos2
integer x = 1975
integer y = 532
integer width = 699
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "No Agrupar por Serie"
end type

