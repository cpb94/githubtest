$PBExportHeader$w_int_movalmprod.srw
forward
global type w_int_movalmprod from w_int_con_empresa
end type
type st_texto_cantidad from statictext within w_int_movalmprod
end type
type st_9 from statictext within w_int_movalmprod
end type
type pb_1 from upb_salir within w_int_movalmprod
end type
type em_cantidad from u_em_campo within w_int_movalmprod
end type
type sle_observaciones from u_em_campo within w_int_movalmprod
end type
type cb_1 from u_boton within w_int_movalmprod
end type
type uo_articulo from u_em_campo_2 within w_int_movalmprod
end type
type cb_5 from commandbutton within w_int_movalmprod
end type
type st_1 from statictext within w_int_movalmprod
end type
type em_zona from u_em_campo within w_int_movalmprod
end type
type em_fila from u_em_campo within w_int_movalmprod
end type
type em_altura from u_em_campo within w_int_movalmprod
end type
type st_texto_1 from statictext within w_int_movalmprod
end type
type st_texto_2 from statictext within w_int_movalmprod
end type
type st_texto_3 from statictext within w_int_movalmprod
end type
type st_texto_4 from statictext within w_int_movalmprod
end type
type st_texto_5 from statictext within w_int_movalmprod
end type
type em_f_alta from u_em_campo within w_int_movalmprod
end type
type uo_almacen from u_em_campo_2 within w_int_movalmprod
end type
type dw_2 from datawindow within w_int_movalmprod
end type
type cb_2 from commandbutton within w_int_movalmprod
end type
type dw_1 from datawindow within w_int_movalmprod
end type
end forward

global type w_int_movalmprod from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 2953
integer height = 1320
string icon = "\bmp\RINO.ICO"
st_texto_cantidad st_texto_cantidad
st_9 st_9
pb_1 pb_1
em_cantidad em_cantidad
sle_observaciones sle_observaciones
cb_1 cb_1
uo_articulo uo_articulo
cb_5 cb_5
st_1 st_1
em_zona em_zona
em_fila em_fila
em_altura em_altura
st_texto_1 st_texto_1
st_texto_2 st_texto_2
st_texto_3 st_texto_3
st_texto_4 st_texto_4
st_texto_5 st_texto_5
em_f_alta em_f_alta
uo_almacen uo_almacen
dw_2 dw_2
cb_2 cb_2
dw_1 dw_1
end type
global w_int_movalmprod w_int_movalmprod

type variables
//str_parametros  istr_parametros
   integer contador,v_altura,v_fila,anyo
  decimal{4} v_cantidad
  decimal{4} ante_valor, ante_cant
  String v_almacen,v_zona,cod_sector
  string ante_numdoc
  String situado
  Boolean  control_tono,control_calibre
// Defino la estructura de la tablas a procesar
   str_almlinubicahis  ubihis
   str_almlinubica      ubi
   str_almmovhis       mov
// Especial: modificación de entradas
Boolean especial = false



end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Introduccion Movimientos Entradas Formulas"
This.title=istr_parametros.s_titulo_ventana
dw_1.visible=false
dw_1.Settransobject(SQLCA)
dw_2.Settransobject(SQLCA)

uo_articulo.em_codigo.text = ""
uo_articulo.em_campo.text = ""
uo_almacen.em_codigo.text = ""
uo_almacen.em_campo.text = ""
em_zona.text = ""
em_fila.text = ""
em_altura.text = ""
em_f_alta.text = string(today(),"dd/mm/yy")
em_cantidad.text = ""
sle_observaciones.text = ""
uo_articulo.em_campo.setfocus()

end event

on w_int_movalmprod.create
int iCurrent
call super::create
this.st_texto_cantidad=create st_texto_cantidad
this.st_9=create st_9
this.pb_1=create pb_1
this.em_cantidad=create em_cantidad
this.sle_observaciones=create sle_observaciones
this.cb_1=create cb_1
this.uo_articulo=create uo_articulo
this.cb_5=create cb_5
this.st_1=create st_1
this.em_zona=create em_zona
this.em_fila=create em_fila
this.em_altura=create em_altura
this.st_texto_1=create st_texto_1
this.st_texto_2=create st_texto_2
this.st_texto_3=create st_texto_3
this.st_texto_4=create st_texto_4
this.st_texto_5=create st_texto_5
this.em_f_alta=create em_f_alta
this.uo_almacen=create uo_almacen
this.dw_2=create dw_2
this.cb_2=create cb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_texto_cantidad
this.Control[iCurrent+2]=this.st_9
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.em_cantidad
this.Control[iCurrent+5]=this.sle_observaciones
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_articulo
this.Control[iCurrent+8]=this.cb_5
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.em_zona
this.Control[iCurrent+11]=this.em_fila
this.Control[iCurrent+12]=this.em_altura
this.Control[iCurrent+13]=this.st_texto_1
this.Control[iCurrent+14]=this.st_texto_2
this.Control[iCurrent+15]=this.st_texto_3
this.Control[iCurrent+16]=this.st_texto_4
this.Control[iCurrent+17]=this.st_texto_5
this.Control[iCurrent+18]=this.em_f_alta
this.Control[iCurrent+19]=this.uo_almacen
this.Control[iCurrent+20]=this.dw_2
this.Control[iCurrent+21]=this.cb_2
this.Control[iCurrent+22]=this.dw_1
end on

on w_int_movalmprod.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_texto_cantidad)
destroy(this.st_9)
destroy(this.pb_1)
destroy(this.em_cantidad)
destroy(this.sle_observaciones)
destroy(this.cb_1)
destroy(this.uo_articulo)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.em_zona)
destroy(this.em_fila)
destroy(this.em_altura)
destroy(this.st_texto_1)
destroy(this.st_texto_2)
destroy(this.st_texto_3)
destroy(this.st_texto_4)
destroy(this.st_texto_5)
destroy(this.em_f_alta)
destroy(this.uo_almacen)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_movalmprod
integer x = 773
integer y = 156
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_movalmprod
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_movalmprod
integer width = 2656
end type

type st_texto_cantidad from statictext within w_int_movalmprod
integer x = 827
integer y = 196
integer width = 384
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_9 from statictext within w_int_movalmprod
integer x = 224
integer y = 376
integer width = 439
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Observaciones"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_movalmprod
integer x = 2702
integer y = 36
integer width = 128
integer height = 108
integer taborder = 0
alignment htextalign = right!
end type

type em_cantidad from u_em_campo within w_int_movalmprod
integer x = 827
integer y = 272
integer width = 384
integer taborder = 40
integer textsize = -9
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.00"
end type

event modificado;call super::modificado;if this.text <>"" then
	dw_2.retrieve (codigo_empresa,uo_articulo.em_codigo.text,real(this.text))
	dw_2.visible = true
end if
end event

type sle_observaciones from u_em_campo within w_int_movalmprod
integer x = 718
integer y = 376
integer width = 1847
integer taborder = 90
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;situado= "OBSERVACIONES"
end event

type cb_1 from u_boton within w_int_movalmprod
integer x = 2578
integer y = 372
integer width = 274
integer height = 88
integer taborder = 100
string text = "&Grabar"
end type

event clicked;//CONTROLES DE VALORES
int bien = 0
int v_anyo
datetime v_fecha
string mensaje,v_formula,v_observaciones
// piezas por conjunto

IF trim(em_f_alta.text)="00-00-00" THEN
   mensaje="Introduzca la fecha"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_f_alta.SetFocus()
   RETURN
END IF


IF trim(uo_almacen.em_codigo.text)=""  or IsNull(uo_almacen.em_codigo.text) THEN
   mensaje="Introduzca el almacen"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_almacen.em_codigo.Setfocus()
   RETURN
END IF

IF trim(em_zona.text)="" THEN
   mensaje="Introduzca la zona"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   em_zona.Setfocus()
   RETURN
END IF

IF trim(uo_articulo.em_campo.text)="" THEN
   mensaje="Introduzca la formula"
   MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
   uo_articulo.em_campo.Setfocus()
   RETURN
END IF

 IF trim(em_fila.text)="" THEN
   mensaje="Introduzca la fila"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_fila.Setfocus()
   RETURN
 END IF

IF trim(em_altura.text)="" THEN
   mensaje="Introduzca la altura"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_altura.SetFocus()
   RETURN
END IF

IF trim(em_cantidad.text)="" THEN
   mensaje="Introduzca la cantidad"
   MessageBox("Campo obligatorio",mensaje,Exclamation!,OK!,1)
   em_cantidad.SetFocus()
   RETURN
END IF

real v_existencias
long v_linea
string v_ubicacion
datetime v_f_alta

v_existencias = real (em_cantidad.text)
v_fila = integer(em_fila.text)
v_altura = integer(em_altura.text)
v_ubicacion = trim(uo_almacen.em_codigo.text)+"/"+trim(em_zona.text)+"/"+trim(em_fila.text)+"/"+trim(em_altura.text)
v_f_alta = datetime (date(em_f_alta.text))

select max(linea) into :v_linea
from prodformlinubica where
empresa = :codigo_empresa;

if IsNull(v_linea) then
	v_linea = 0
end if

v_linea = v_linea + 1
////////////////////////
long indice,total,bien2
str_parametros lstr_param 
string mp,var_descripcion
real cantidad,disponible

bien2 = 0
total = dw_2.rowcount()
lstr_param.i_nargumentos = total + 1
lstr_param.s_argumentos[1]="proceso"

for indice = 1 to total
	lstr_param.s_argumentos[indice * 2] = dw_2.GetItemString(indice,"mp")	
	lstr_param.s_argumentos[(indice * 2) +1] = string(dw_2.GetItemnumber(indice,"cantidad_total_mp"))
	mp = dw_2.GetItemString(indice,"mp")
	cantidad = dw_2.GetItemnumber(indice,"cantidad_total_mp") / 1000
	cantidad = cantidad / f_equivalencia_kg_mp (codigo_empresa , mp)
	disponible = f_existencias_mp (codigo_empresa , mp)		
	if disponible < cantidad then
		select descripcion
		Into   :var_descripcion
		from   venmprima
		Where  venmprima.empresa  =  :codigo_empresa
		And    venmprima.codigo   =  :mp;
		bien2 = 1
		messagebox("Error en proceso automatico:","No puede generar la salida automatica~npor falta de stock del Articulo:~n"+var_descripcion)
	end if
next
if bien2 = 0 then
	OpenWithParm(w_int_movsalidas_compras,lstr_param)
	
	insert into prodformlinubica
			(empresa,almacen
			,zona
			,fila
			,altura
			,linea
			,formula
			,existencias
			,ubicacion
			,f_alta
			,observaciones)
	values (:codigo_empresa
			 ,:uo_almacen.em_codigo.text
			 ,:em_zona.text
			 ,:v_fila
			 ,:v_altura
			 ,:v_linea
			 ,:uo_articulo.em_codigo.text
			 ,:v_existencias
			 ,:v_ubicacion
			 ,:v_f_alta
			 ,:sle_observaciones.text);
	IF SQLCA.SQLCODE <> 0 Then
		f_mensaje("Error en base de datos (Funcion Insertar linea)",sqlca.sqlerrtext)
		bien = 1
	end if
		v_anyo = year(date(em_f_alta.text))
		v_fecha = datetime(date(em_f_alta.text))
		v_formula = uo_articulo.em_codigo.text
		v_cantidad = real(em_cantidad.text)
		v_observaciones = sle_observaciones.text
		v_linea = f_linea_his_form (codigo_empresa,v_anyo)
		insert into prodmovformhis
		(empresa,anyo,linea,
		fecha,formula,
		cantidad,observaciones,
		entrada_salida)
		values
		(:codigo_empresa,:v_anyo,:v_linea,
		:v_fecha,:v_formula,
		:v_cantidad,:v_observaciones,
		"E");
		IF SQLCA.SQLCODE <> 0 Then
			f_mensaje("Error en base de datos inserción prodmovforhis",sqlca.sqlerrtext)
			bien = 1
		END IF				
	
	if bien = 1 then
		rollback;
		dw_1.retrieve (codigo_empresa , uo_articulo.em_codigo.text)
		dw_1.visible = true
		em_cantidad.text = "";
		uo_articulo.em_campo.setfocus()
	ELSE
		commit;
		dw_1.visible = false
		dw_2.visible = false
		uo_articulo.em_codigo.text = ""
		uo_articulo.em_campo.text = ""
		uo_almacen.em_codigo.text = ""
		uo_almacen.em_campo.text = ""
		em_zona.text = ""
		em_fila.text = ""
		em_altura.text = ""
		em_f_alta.text = string(today(),"dd/mm/yy")
		em_cantidad.text = ""
		sle_observaciones.text = ""
		uo_articulo.em_campo.setfocus()
	END IF		
		
end if


end event

type uo_articulo from u_em_campo_2 within w_int_movalmprod
integer x = 18
integer y = 272
integer width = 809
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;
uo_articulo.em_campo.text = Trim(f_nombre_formulacion_produccion(codigo_empresa,uo_articulo.em_codigo.text))
IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then 
		uo_articulo.em_campo.SetFocus()
	END IF
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
ELSE
	dw_1.retrieve (codigo_empresa , uo_articulo.em_codigo.text)
	dw_1.visible = true
END IF

end event

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodformulaciones"
ue_titulo      = "AYUDA SELECCION DE FORMULACIONES"
ue_filtro      =""

end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type cb_5 from commandbutton within w_int_movalmprod
integer x = 18
integer y = 196
integer width = 805
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_formulaciones, lstr_param)
end event

type st_1 from statictext within w_int_movalmprod
integer x = 283
integer y = 200
integer width = 288
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "formula"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;str_parametros lstr_param
OpenWithParm(wi_mant_articulos, lstr_param)
end event

type em_zona from u_em_campo within w_int_movalmprod
integer x = 1911
integer y = 272
integer width = 206
integer taborder = 60
integer textsize = -9
alignment alignment = right!
string mask = "a"
end type

type em_fila from u_em_campo within w_int_movalmprod
integer x = 2117
integer y = 272
integer width = 206
integer taborder = 70
integer textsize = -9
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#####"
end type

type em_altura from u_em_campo within w_int_movalmprod
integer x = 2327
integer y = 272
integer width = 206
integer taborder = 80
integer textsize = -9
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#####"
end type

type st_texto_1 from statictext within w_int_movalmprod
integer x = 1216
integer y = 196
integer width = 686
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Almacen"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_2 from statictext within w_int_movalmprod
integer x = 1906
integer y = 196
integer width = 206
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Zona"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_3 from statictext within w_int_movalmprod
integer x = 2117
integer y = 196
integer width = 206
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fila"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_4 from statictext within w_int_movalmprod
integer x = 2327
integer y = 196
integer width = 206
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Altura"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_texto_5 from statictext within w_int_movalmprod
integer x = 2537
integer y = 196
integer width = 306
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_f_alta from u_em_campo within w_int_movalmprod
integer x = 2542
integer y = 272
integer width = 306
integer taborder = 20
boolean bringtotop = true
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type uo_almacen from u_em_campo_2 within w_int_movalmprod
event destroy ( )
integer x = 1216
integer y = 272
integer width = 686
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_almacen.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_almacen.em_campo.text = Trim(f_nombre_almacen(codigo_empresa,uo_almacen.em_codigo.text))
IF Trim(uo_almacen.em_campo.text)="" THEN 
	IF Trim(uo_almacen.em_codigo.text)<>"" Then 
		uo_almacen.em_campo.SetFocus()
	END IF
	uo_almacen.em_campo.text=""
	uo_almacen.em_codigo.text=""
	Return

END IF

end event

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_almacenes"
ue_titulo      = "AYUDA SELECCION DE ALMACENES"
ue_filtro      =""

end event

type dw_2 from datawindow within w_int_movalmprod
boolean visible = false
integer x = 1207
integer y = 480
integer width = 1449
integer height = 528
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_movalm_detalleformulas_kg"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;this.visible = false
em_cantidad.setfocus()
end event

type cb_2 from commandbutton within w_int_movalmprod
boolean visible = false
integer x = 1207
integer y = 1020
integer width = 878
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Salida Almacen Mp"
end type

event clicked;long indice,total,bien
str_parametros lstr_param 
string mp,var_descripcion
real cantidad,disponible

bien = 0
total = dw_2.rowcount()
lstr_param.i_nargumentos = total + 1
lstr_param.s_argumentos[1]="proceso"

for indice = 1 to total
	lstr_param.s_argumentos[indice * 2]=dw_2.GetItemString(indice,"mp")	
	lstr_param.s_argumentos[(indice * 2) +1]=string(dw_2.GetItemnumber(indice,"cantidad_total_mp"))
	mp = trim(istr_parametros.s_argumentos[indice * 2])
	cantidad = real(istr_parametros.s_argumentos[(indice * 2) +1])/1000
	cantidad = cantidad / f_equivalencia_kg_mp (codigo_empresa,mp)
	disponible = f_existencias_mp (codigo_empresa,mp)		
	if disponible < cantidad then
		select descripcion
		Into   :var_descripcion
		from   venmprima
		Where  venmprima.empresa  =  :codigo_empresa
		And    venmprima.codigo   =  :mp;
		bien = 1
		messagebox("Error en proceso automatico:","No puede generar la salida automatica~npor falta de stock del Articulo:~n"+var_descripcion)
	end if
next
if bien = 0 then
	OpenWithParm(w_int_movsalidas_compras,lstr_param)
end if

end event

type dw_1 from datawindow within w_int_movalmprod
integer x = 23
integer y = 480
integer width = 1175
integer height = 528
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_int_almlinubiprod"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if this.rowcount() <> 0 then
	uo_almacen.em_codigo.text = this.getitemstring(this.getrow(),"prodformlinubica_almacen")
	uo_almacen.triggerevent("modificado")
	em_zona.text    = this.getitemstring(this.getrow(),"prodformlinubica_zona")
	em_zona.triggerevent("modificado")
	em_fila.text	 = string(this.getitemnumber(this.getrow(),"prodformlinubica_fila"))
	em_fila.triggerevent("modificado")
	em_altura.text  = string(this.getitemnumber(this.getrow(),"prodformlinubica_altura"))	
	em_altura.triggerevent("modificado")
end if
end event

event doubleclicked;
if this.describe("datawindow.detail.height") = "72" then
	this.modify("datawindow.detail.height=0")
else
	this.modify("datawindow.detail.height=72")
end if
end event

