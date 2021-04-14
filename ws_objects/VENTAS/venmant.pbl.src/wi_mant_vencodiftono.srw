$PBExportHeader$wi_mant_vencodiftono.srw
forward
global type wi_mant_vencodiftono from wi_mvent_con_empresa
end type
type st_2 from statictext within wi_mant_vencodiftono
end type
type st_3 from statictext within wi_mant_vencodiftono
end type
type st_4 from statictext within wi_mant_vencodiftono
end type
type st_5 from statictext within wi_mant_vencodiftono
end type
type sle_tono from editmask within wi_mant_vencodiftono
end type
type sle_calibre from editmask within wi_mant_vencodiftono
end type
type sle_codificacion from editmask within wi_mant_vencodiftono
end type
end forward

global type wi_mant_vencodiftono from wi_mvent_con_empresa
integer width = 2359
integer height = 1620
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
sle_tono sle_tono
sle_calibre sle_calibre
sle_codificacion sle_codificacion
end type
global wi_mant_vencodiftono wi_mant_vencodiftono

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   istr_parametros.s_titulo_ventana = "Codificación de Tonos y Calibres"
//	istr_parametros.s_listado        = "report_venzonas"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       This.TriggerEvent("ue_recuperar")
		 cb_insertar.enabled=true
		 cb_borrar.enabled=true
      END IF
   END IF

	sle_tono.text="0"
	sle_calibre.text="0"
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "vencodiftono"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

//CALL Super::ue_recuperar
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on wi_mant_vencodiftono.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.sle_tono=create sle_tono
this.sle_calibre=create sle_calibre
this.sle_codificacion=create sle_codificacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.sle_tono
this.Control[iCurrent+6]=this.sle_calibre
this.Control[iCurrent+7]=this.sle_codificacion
end on

on wi_mant_vencodiftono.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_tono)
destroy(this.sle_calibre)
destroy(this.sle_codificacion)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vencodiftono
integer x = 41
integer y = 528
integer width = 2213
integer height = 832
string dataobject = "dw_codificacion_tono_cal"
end type

event dw_1::clicked;// no se puede seleccionar en una crosstab
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vencodiftono
integer x = 169
integer y = 220
integer width = 283
string text = "Cliente"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vencodiftono
integer x = 1184
integer y = 392
integer width = 334
end type

event cb_insertar::clicked;Integer v_num,v_tono,v_calibre,v_resp
// Control de campos obligatorios
if Trim(sle_tono.text)="" then
	f_mensaje("Campo Obligatorio","Introduzca el Tono")
	sle_tono.setfocus()
	Return
end if

if Trim(sle_calibre.text)="" then
	f_mensaje("Campo Obligatorio","Introduzca el Calibre")
	sle_calibre.setfocus()
	Return
end if

if Trim(sle_codificacion.text)="" then
	f_mensaje("Campo Obligatorio","Introduzca la Codificación")
	sle_codificacion.setfocus()
	Return
end if
v_tono = Dec(sle_tono.text)
v_calibre = Dec(sle_calibre.text)

Select Count(*)
into :v_num
from vencodiftono
where empresa = :codigo_empresa
	and cliente = :sle_valor.text
	and tono   = :v_tono
	and calibre = :v_calibre;
	
if v_num>0 then
   v_resp=MessageBox("Codificación Existente","Ya existe una codificación para ese tono y ese calibre.¿Desea Cambiarla?",Question!,OkCancel!)
	if v_resp=1 then
		update vencodiftono
		set codificacion = :sle_codificacion.text
		where empresa = :codigo_empresa
			and cliente = :sle_valor.text
			and tono    = :v_tono
			and calibre = :v_calibre;
	else
		Return		
	end if
	
else
	dw_1.reset()
	Insert into vencodiftono (empresa,cliente,tono,calibre,codificacion)
	values (:codigo_empresa,:sle_valor.text,:v_tono,:v_calibre,:sle_codificacion.text)
	using sqlca;
	if sqlca.sqlcode=0 then
		COMMIT;
		sle_tono.text = "0"
		sle_calibre.text = "0"
		sle_codificacion.text = ""
		
	else
		f_mensaje("Error en inserción","No se ha podido insertar la codificación")
		ROLLBACK;
	END IF
	
end if	
// refrescamos la datawindow
dw_1.retrieve(codigo_empresa,sle_valor.text)	
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vencodiftono
integer x = 1554
integer y = 392
integer width = 334
end type

event cb_borrar::clicked;Integer v_tono,v_calibre,v_resp

// Control de campos obligatorios
if Trim(sle_tono.text)="" then
	f_mensaje("Campo Obligatorio","Introduzca el Tono")
	sle_tono.setfocus()
	Return
end if

if Trim(sle_calibre.text)="" then
	f_mensaje("Campo Obligatorio","Introduzca el Calibre")
	sle_calibre.setfocus()
	Return
end if

v_resp=MessageBox("Borrado de una Codificación","¿Está seguro de que desea eliminar esta codificación?",Question!,OkCancel!)
if v_resp=1 then
	v_tono = Dec(sle_tono.text)
	v_calibre = Dec(sle_calibre.text)
	delete from vencodiftono
	where empresa = :codigo_empresa
	 and cliente  = :sle_valor.text
	 and tono     = :v_tono
	 and calibre  = :v_calibre
	 using sqlca;
	 
	if sqlca.sqlcode = 0 then
		COMMIT;
		sle_tono.text = "0"
		sle_calibre.text = "0"
		sle_codificacion.text = ""

	else
		ROLLBACK;
		f_mensaje("Error en borrado","No se puede eliminar esa codificación")
	end if
else
	Return	 
end if

dw_1.Retrieve(codigo_empresa,sle_valor.text)
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vencodiftono
integer x = 457
integer y = 208
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 	

end event

event sle_valor::modificado;call super::modificado;st_2.text = f_nombre_cliente(codigo_empresa,"C",sle_valor.text)

if Trim(st_2.text)<>"" then
	dw_1.visible = true
	dw_1.Reset()
	dw_1.Retrieve (codigo_empresa,sle_valor.text)
	cb_insertar.enabled=true
	cb_borrar.enabled=true
else
	dw_1.visible = false
end if
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vencodiftono
integer x = 1911
integer y = 392
integer width = 334
end type

event cb_salir::clicked;Close(Parent)
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vencodiftono
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vencodiftono
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vencodiftono
integer width = 2816
end type

type st_2 from statictext within wi_mant_vencodiftono
integer x = 731
integer y = 220
integer width = 1161
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_vencodiftono
integer x = 187
integer y = 332
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Tono"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within wi_mant_vencodiftono
integer x = 434
integer y = 332
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Calibre"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within wi_mant_vencodiftono
integer x = 681
integer y = 332
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Codificación"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_tono from editmask within wi_mant_vencodiftono
integer x = 187
integer y = 400
integer width = 247
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type sle_calibre from editmask within wi_mant_vencodiftono
integer x = 434
integer y = 400
integer width = 247
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "####0"
end type

type sle_codificacion from editmask within wi_mant_vencodiftono
integer x = 681
integer y = 400
integer width = 338
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!"
end type

