$PBExportHeader$wi_mant_articulocaja.srw
forward
global type wi_mant_articulocaja from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_articulocaja
end type
type st_nombre_articulo from statictext within wi_mant_articulocaja
end type
type sle_articulo from u_em_campo within wi_mant_articulocaja
end type
type st_caja_nombre from statictext within wi_mant_articulocaja
end type
type pb_1 from picturebutton within wi_mant_articulocaja
end type
type dw_articulocaja from datawindow within wi_mant_articulocaja
end type
type sle_inicial from singlelineedit within wi_mant_articulocaja
end type
type sle_final from singlelineedit within wi_mant_articulocaja
end type
type st_2 from statictext within wi_mant_articulocaja
end type
type st_3 from statictext within wi_mant_articulocaja
end type
type cb_1 from commandbutton within wi_mant_articulocaja
end type
type st_porcentaje from statictext within wi_mant_articulocaja
end type
type cb_2 from commandbutton within wi_mant_articulocaja
end type
type dw_elementos from u_datawindow within wi_mant_articulocaja
end type
type pb_2 from picturebutton within wi_mant_articulocaja
end type
type pb_3 from picturebutton within wi_mant_articulocaja
end type
type r_1 from rectangle within wi_mant_articulocaja
end type
end forward

global type wi_mant_articulocaja from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3863
integer height = 2140
st_almacen st_almacen
st_nombre_articulo st_nombre_articulo
sle_articulo sle_articulo
st_caja_nombre st_caja_nombre
pb_1 pb_1
dw_articulocaja dw_articulocaja
sle_inicial sle_inicial
sle_final sle_final
st_2 st_2
st_3 st_3
cb_1 cb_1
st_porcentaje st_porcentaje
cb_2 cb_2
dw_elementos dw_elementos
pb_2 pb_2
pb_3 pb_3
r_1 r_1
end type
global wi_mant_articulocaja wi_mant_articulocaja

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,sle_articulo.text,sle_valor.text)

dw_articulocaja.Retrieve(codigo_empresa,sle_articulo.text)

dw_elementos.Retrieve(codigo_empresa,sle_articulo.text,sle_valor.text)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de cajas por artículo"
istr_parametros.s_listado        = "report_palcajas"
This.title=istr_parametros.s_titulo_ventana
dw_articulocaja.SetTransObject(SQLCA)
dw_elementos.SetTransObject(SQLCA)

//f_mascara_columna(dw_1,"alturas","###.0")

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"articulo",sle_articulo.text)
dw_1.setitem(dw_1.getrow(),"caja",sle_valor.text)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_articulo.text))
criterio[2]   =  trim(sle_articulo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "almartcajas"



f_control()
CALL Super::ue_recuperar
end event

on wi_mant_articulocaja.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_articulo=create st_nombre_articulo
this.sle_articulo=create sle_articulo
this.st_caja_nombre=create st_caja_nombre
this.pb_1=create pb_1
this.dw_articulocaja=create dw_articulocaja
this.sle_inicial=create sle_inicial
this.sle_final=create sle_final
this.st_2=create st_2
this.st_3=create st_3
this.cb_1=create cb_1
this.st_porcentaje=create st_porcentaje
this.cb_2=create cb_2
this.dw_elementos=create dw_elementos
this.pb_2=create pb_2
this.pb_3=create pb_3
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_articulo
this.Control[iCurrent+3]=this.sle_articulo
this.Control[iCurrent+4]=this.st_caja_nombre
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_articulocaja
this.Control[iCurrent+7]=this.sle_inicial
this.Control[iCurrent+8]=this.sle_final
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.st_porcentaje
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.dw_elementos
this.Control[iCurrent+15]=this.pb_2
this.Control[iCurrent+16]=this.pb_3
this.Control[iCurrent+17]=this.r_1
end on

on wi_mant_articulocaja.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_articulo)
destroy(this.sle_articulo)
destroy(this.st_caja_nombre)
destroy(this.pb_1)
destroy(this.dw_articulocaja)
destroy(this.sle_inicial)
destroy(this.sle_final)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.st_porcentaje)
destroy(this.cb_2)
destroy(this.dw_elementos)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.r_1)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_articulo.enabled=FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;sle_articulo.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_articulocaja
integer x = 32
integer y = 404
integer width = 1870
integer height = 864
string dataobject = "dw_articulocaja"
end type

event dw_1::clicked;call super::clicked;//CHOOSE CASE f_objeto_datawindow(dw_1)
//CASE "calcular"
String promocion = "", metros_caja_string
Dec parte_decimal
string unidad

if dwo.name = "calcular" then
	Dec{4} peso_caja,peso_envase,peso_piezas,metros_caja,metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho, metros_caja_reales
	String cod_formato
	
	var_piezas     = dw_1.GetItemNumber(dw_1.GetRow(),"piezascaja")
	var_peso_pieza = f_peso_articulo (codigo_empresa,sle_articulo.text)
	
	peso_piezas = var_peso_pieza  * var_piezas
	peso_envase     = f_peso_envase(codigo_empresa,sle_valor.text)
	
	peso_caja     = peso_envase + peso_piezas
	
	cod_formato = f_formato_articulo (codigo_empresa,sle_articulo.text)
	
//	var_largo = f_largo_formato(codigo_empresa,cod_formato)
//	var_ancho = f_ancho_formato(codigo_empresa,cod_formato)
		
	select ancho_std, largo_std, unidad
	into :var_ancho, :var_largo, :unidad
	from articulos
	where empresa = :codigo_empresa 
	and codigo = :sle_articulo.text
	USING SQLCA;

	//***
	
	metros_caja_reales  = (var_piezas * var_largo*var_ancho)/10000
	
	//REDONDEO CONVENCIONAL CON TANTOS DECIMALES COMO INDIQUE EL CAMPO articulos.decimales_unidad - JORGE 02/09/2015
	//REDONDEO HACIA ARRIBA - Jorge 15/07/2015 
	//	metros_caja_string = String(metros_caja_reales, "###,###.00")
	//	parte_decimal = dec(metros_caja_string)
	//	if metros_caja_reales > parte_decimal and String(metros_caja_reales, "###,###.0000") <> String(parte_decimal, "###,###.00") then 
	//		metros_caja =  parte_decimal + 0.01
	//	else
	//		metros_caja = parte_decimal
	//	end if

	
	// Si la unidad es m2 calculamos los con los decimales que tenga definido el articulo, sino hacemos el cálculo a 4 decimales
	if unidad = '1' then
		metros_caja = round(metros_caja_reales, ftc_decimales_articulo(codigo_empresa, sle_articulo.text))
	else
		metros_caja = round(metros_caja_reales, 4)
	end if		
	
   	metrosl_caja = (var_piezas * var_largo)/100
	
//	SELECT promocion INTO :promocion FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_articulo.text;
//	
//	if promocion = 'S' then
//		metros_caja = 0
//		metrosl_caja = 0
//		peso_caja = 0
//	end if
   
	dw_1.SetItem(dw_1.GetRow(),"pesocaja",peso_caja)
	dw_1.SetItem(dw_1.GetRow(),"metroscaja",metros_caja)
	dw_1.SetItem(dw_1.GetRow(),"metros_reales",metros_caja)
	dw_1.SetItem(dw_1.GetRow(),"metroslcaja",metrosl_caja)
	dw_1.object.pordefecto[dw_1.GetRow()] = 'S'
end if
//END CHOOSE

end event

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "codigo"
	bus_titulo     = "VENTANA SELECCION DE CAJAS "
	bus_datawindow = "dw_ayuda_venmprima"
	bus_filtro = "tipo_materia = '13'"
END CHOOSE
CALL Super::Key


end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "codigo"
	bus_titulo     = "VENTANA SELECCION DE CAJAS "
	bus_datawindow = "dw_ayuda_venmprima"
	bus_filtro = "tipo_materia = '13'"
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::itemchanged;call super::itemchanged;if row > 0 then
	if dwo.name = "piezascaja" and MessageBox("¡Atención!", "Se van a actualizar automáticamente los datos de metros, peso,... ¿desea continuar?", Question!, YesNo!, 2) = 1 then
		this.EVENT clicked(0,0, this.getRow(), this.object.calcular)
	end if
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_articulocaja
integer x = 18
integer y = 284
integer width = 343
integer height = 80
string text = "Caja"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_articulocaja
integer x = 2450
integer y = 180
integer width = 334
integer height = 100
end type

event cb_insertar::clicked;Dec num, num_pedidos = 0
String promocion, familia = "", bloqueo_packing

long i

for i = dw_elementos.rowcount() to 1 step -1
	
	if dw_elementos.object.cod_elemento[i] = "" then
		
		dw_elementos.deleterow(i)
		
	end if
		
next

dw_elementos.accepttext()
dw_elementos.update()
commit;

if dw_1.rowcount()>0 then
	dw_1.AcceptText()
	
	SELECT promocion, familia, bloqueo_packing
	INTO :promocion, :familia , :bloqueo_packing
	FROM articulos 
	WHERE empresa = :codigo_empresa 
		AND codigo = :sle_articulo.text
	USING SQLCA;
	
	if  bloqueo_packing = 'S' then
		 MessageBox("¡Atención!", "NO se puede modificar el packing. El Artículo tiene el packing confirmado. Avisar a Departamento de Hornos. ",StopSign!,OK!)
		return
	end if


//	SELECT ISNULL(COUNT(*), 0) 
//	INTO :num_pedidos 
//	FROM venliped 
//	WHERE articulo = :sle_articulo.text 
//		AND caja = :sle_valor.text
//	USING SQLCA;

//	if num_pedidos > 0 /*and (familia = "2" or familia = "3" or familia = "4") */ then
//		 MessageBox("¡Atención!", "Existe algún pedido en marcha.~n 	NO SE PUEDEN CAMBIAR LAS ESPECIFICACIONES ",StopSign!,OK!)
//		return
//	end if
	
	num = dw_1.GetItemNumber(dw_1.GetRow(),"piezascaja")
	if IsNull(num) then num = 0
	if num = 0 then 
		f_mensaje("No puedo guardar los datos de la caja","Debe introducir el número de piezas por caja")
		dw_1.SetFocus()
		dw_1.SetColumn("piezascaja")
		return
	end if
	
	num = dw_1.GetItemNumber(dw_1.GetRow(),"metroscaja")
	if IsNull(num) then num = 0
	if num = 0 and promocion = 'N' then 
		f_mensaje("No puedo guardar los datos de la caja","Debe introducir el número de metros por caja. Puede pulsar la calculadora para que se calcule automáticamente")
		dw_1.SetFocus()
		dw_1.SetColumn("metroscaja")
		return
	end if
	
	num = dw_1.GetItemNumber(dw_1.GetRow(),"metroslcaja")
	if IsNull(num) then num = 0
	if num = 0 and promocion = 'N' then 
		f_mensaje("No puedo guardar los datos de la caja","Debe introducir el número de metros lineales por caja. Puede pulsar la calculadora para que se calcule automáticamente")
		dw_1.SetFocus()
		dw_1.SetColumn("metroslcaja")
		return
	end if
	
	num = dw_1.GetItemNumber(dw_1.GetRow(),"pesocaja")
	if IsNull(num) then num = 0
	if num = 0 then 
		f_mensaje("No puedo guardar los datos de la caja","Debe introducir el peso por caja. Puede pulsar la calculadora para que se calcule automáticamente")
		dw_1.SetFocus()
		dw_1.SetColumn("pesocaja")
		return
	end if
	string caja
	caja = dw_1.getitemstring(1,"codigo")
	dw_1.setitem(1,"descripcion",f_nombre_mprima(codigo_empresa,caja))	
end if

if dw_1.GetItemString(dw_1.GetRow(),"pordefecto") = 'S' then

	update almartcajas set pordefecto = 'N' 
	where empresa = :codigo_empresa
		and articulo = :sle_articulo.text
		and caja <> :sle_valor.text 
	USING SQLCA;

	IF SQLCA.SQLCODE <> 0 THEN
		rollback using sqlca;
	else
		commit using sqlca;
	end if

end if

call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_articulocaja
integer x = 2811
integer y = 180
integer width = 334
integer height = 100
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_articulocaja
integer x = 393
integer y = 276
integer width = 338
integer taborder = 20
end type

event sle_valor::modificado;call super::modificado;st_caja_nombre.text=f_nombre_caja(codigo_empresa,sle_valor.text)
IF Trim(st_caja_nombre.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end event

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE CAJAS"
ue_datawindow = "dw_ayuda_cajas"
ue_filtro     = ""
isle_campo    = This

IF trim(sle_articulo.text)= "" THEN
	f_activar_campo(sle_articulo)
	Return	 
End if	
f_control()
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_articulocaja
integer x = 3173
integer y = 180
integer width = 334
integer height = 100
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_articulocaja
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_articulocaja
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_articulocaja
integer width = 3141
end type

type st_almacen from statictext within wi_mant_articulocaja
integer x = 18
integer y = 180
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_articulo from statictext within wi_mant_articulocaja
integer x = 896
integer y = 172
integer width = 1454
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_articulo from u_em_campo within wi_mant_articulocaja
integer x = 398
integer y = 172
integer width = 466
integer taborder = 10
end type

event getfocus;call super::getfocus;  ue_titulo     = "AYUDA SELECCION DE ARTÍCULOS"
  ue_datawindow = "dw_ayuda_articulos"
  ue_filtro     = ""
  isle_campo    = This
  sle_valor.Text = ""
  
  f_control()
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_articulo.text=istr_parametros.s_argumentos[2]	
     sle_articulo.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_articulo.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_valor)
			 Return
		else
			 f_activar_campo(sle_valor)
			 Return
     END IF
  END IF







end event

event modificado;call super::modificado;st_nombre_articulo.text=f_nombre_articulo(codigo_empresa,sle_articulo.text)
IF Trim(st_nombre_articulo.text)="" THEN 
 IF Trim(sle_articulo.text)<>"" Then  f_activar_campo(sle_articulo)
 sle_articulo.text=""
END IF
end event

type st_caja_nombre from statictext within wi_mant_articulocaja
integer x = 896
integer y = 276
integer width = 1454
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within wi_mant_articulocaja
integer x = 754
integer y = 276
integer width = 110
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "c:\bmp\carpeta.bmp"
alignment htextalign = right!
end type

event clicked;str_parametros lstr_param

lstr_param.s_argumentos[2] = sle_valor.text
OpenWithParm(wi_mant_cajas,lstr_param)  

end event

type dw_articulocaja from datawindow within wi_mant_articulocaja
integer x = 37
integer y = 1368
integer width = 2322
integer height = 504
string dataobject = "dw_articulocaja1"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = This.GetItemString(Row,"caja")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

type sle_inicial from singlelineedit within wi_mant_articulocaja
integer x = 2834
integer y = 1388
integer width = 352
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_final from singlelineedit within wi_mant_articulocaja
integer x = 2834
integer y = 1520
integer width = 352
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within wi_mant_articulocaja
integer x = 2423
integer y = 1520
integer width = 402
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
long textcolor = 32768
long backcolor = 16777215
string text = "Peso Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_articulocaja
integer x = 2423
integer y = 1388
integer width = 402
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
long textcolor = 32768
long backcolor = 16777215
string text = "Peso Incial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within wi_mant_articulocaja
integer x = 2418
integer y = 1648
integer width = 402
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
string text = "Calcular"
end type

event clicked;dec {3} inicial, final, resultado

if sle_inicial.text <> '' and sle_final.text <> '' then
	
	inicial = dec (sle_inicial.text)
	final = dec (sle_final.text)
	
	resultado = ((final - inicial) / final ) * 100
	
	st_porcentaje.text = string (resultado)+ " %"
end if
end event

type st_porcentaje from statictext within wi_mant_articulocaja
integer x = 2839
integer y = 1656
integer width = 334
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
long textcolor = 19993310
long backcolor = 16777215
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within wi_mant_articulocaja
integer x = 2418
integer y = 1756
integer width = 402
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
string text = "Borrar"
end type

event clicked;sle_inicial.text = ''
sle_final.text = ''
st_porcentaje.text = ''
end event

type dw_elementos from u_datawindow within wi_mant_articulocaja
integer x = 2030
integer y = 400
integer width = 1801
integer height = 864
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "ELEMENTOS DE EMBALAJE"
string dataobject = "dw_almartcaj_elementos"
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;if rowcount = 0 then
	
	int donde
	
	donde = dw_elementos.insertrow(0)
	dw_elementos.object.empresa[donde] = codigo_empresa
	dw_elementos.object.articulo[donde] = sle_articulo.text
	dw_elementos.object.caja[donde] = sle_valor.text	
	dw_elementos.object.cantidad[donde] = 0
	dw_elementos.object.cod_elemento[donde] = ""
	dw_elementos.object.tipo[donde] = "C"
	dw_elementos.object.observaciones[donde] = ""
	
end if
end event

event key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "cod_elemento"
	bus_titulo     = "VENTANA SELECCION DE ELEMENTOS "
	bus_datawindow = "dw_ayuda_articulos_codigo"
	bus_filtro = "familia = '0' and subfamilia = '0'"
END CHOOSE
CALL Super::Key

end event

event rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "cod_elemento"
	bus_titulo     = "VENTANA SELECCION DE ELEMENTOS "
	bus_datawindow = "dw_ayuda_articulos_codigo"
	bus_filtro = "familia = '0' and subfamilia = '0'"
END CHOOSE
CALL Super::rbuttondown

end event

type pb_2 from picturebutton within wi_mant_articulocaja
integer x = 3497
integer y = 404
integer width = 110
integer height = 96
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = "Custom008!"
alignment htextalign = left!
string powertiptext = "GRABAR"
end type

event clicked;long i

for i = dw_elementos.rowcount() to 1 step -1
	
	if dw_elementos.object.cod_elemento[i] = "" then
		
		dw_elementos.deleterow(i)
		
	end if
		
next

dw_elementos.accepttext()
dw_elementos.update()
commit;
end event

type pb_3 from picturebutton within wi_mant_articulocaja
integer x = 3607
integer y = 404
integer width = 110
integer height = 96
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "Import1!"
alignment htextalign = left!
string powertiptext = "AÑADIR LINEA"
end type

event clicked;int donde

donde = dw_elementos.insertrow(0)
dw_elementos.object.empresa[donde] = codigo_empresa
dw_elementos.object.articulo[donde] = sle_articulo.text
dw_elementos.object.caja[donde] = sle_valor.text	
dw_elementos.object.cantidad[donde] = 0	
dw_elementos.object.cod_elemento[donde] = ""
dw_elementos.object.tipo[donde] = "C"
dw_elementos.object.observaciones[donde] = ""
end event

type r_1 from rectangle within wi_mant_articulocaja
integer linethickness = 4
long fillcolor = 16777215
integer x = 2395
integer y = 1348
integer width = 823
integer height = 532
end type

