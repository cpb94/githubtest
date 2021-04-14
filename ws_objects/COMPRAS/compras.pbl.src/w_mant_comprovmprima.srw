$PBExportHeader$w_mant_comprovmprima.srw
forward
global type w_mant_comprovmprima from wi_mvent_con_empresa
end type
type st_2 from statictext within w_mant_comprovmprima
end type
type st_nombremprima from statictext within w_mant_comprovmprima
end type
type dw_mprimas from datawindow within w_mant_comprovmprima
end type
type em_proveedor from u_em_campo within w_mant_comprovmprima
end type
type st_proveedor from statictext within w_mant_comprovmprima
end type
end forward

global type w_mant_comprovmprima from wi_mvent_con_empresa
integer width = 2409
integer height = 1480
st_2 st_2
st_nombremprima st_nombremprima
dw_mprimas dw_mprimas
em_proveedor em_proveedor
st_proveedor st_proveedor
end type
global w_mant_comprovmprima w_mant_comprovmprima

on w_mant_comprovmprima.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_nombremprima=create st_nombremprima
this.dw_mprimas=create dw_mprimas
this.em_proveedor=create em_proveedor
this.st_proveedor=create st_proveedor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_nombremprima
this.Control[iCurrent+3]=this.dw_mprimas
this.Control[iCurrent+4]=this.em_proveedor
this.Control[iCurrent+5]=this.st_proveedor
end on

on w_mant_comprovmprima.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.st_nombremprima)
destroy(this.dw_mprimas)
destroy(this.em_proveedor)
destroy(this.st_proveedor)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_proveedor.text))
criterio[2]   =  trim(em_proveedor.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1] + criterio[2] + criterio[3]
tabla         = "comprovmprima"

dw_1.Retrieve(codigo_empresa,em_proveedor.text,sle_valor.Text)

CALL Super::ue_recuperar
end event

event open;call super::open;	tipo_mantenimiento ="C"
	istr_parametros.s_titulo_ventana = "Mantenimiento Materias Primas por Proveedor"
//	istr_parametros.s_listado        = "report_venfampro"
	istr_parametros.s_filtro         = ""
   This.title = istr_parametros.s_titulo_ventana
	dw_mprimas.setTransObject(SQLCA)
   
   // Si recibo el codigo lo visualizo
	   IF istr_parametros.i_nargumentos>1 THEN
		em_proveedor.text=istr_parametros.s_argumentos[2]
		sle_valor.text=istr_parametros.s_argumentos[3]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
			TriggerEvent("ue_recuperar")
         END IF
   END IF
	

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.SetItem(dw_1.GetRow(),"empresa",codigo_empresa)
dw_1.SetItem(dw_1.GetRow(),"proveedor",em_proveedor.text)
dw_1.SetItem(dw_1.GetRow(),"mprima",sle_valor.text)
end event

event ue_activa_claves;call super::ue_activa_claves;em_proveedor.enabled = TRUE

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;em_proveedor.enabled = FALSE

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_comprovmprima
integer x = 146
integer y = 416
integer width = 1755
integer height = 316
string dataobject = "dw_comprovmprima"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_comprovmprima
integer x = 119
integer y = 192
string text = "Proveedor:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_comprovmprima
integer x = 1925
integer y = 416
end type

event cb_insertar::clicked;call super::clicked;dw_mprimas.Retrieve(codigo_empresa,em_proveedor.text)
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_comprovmprima
integer x = 1925
integer y = 528
end type

event cb_borrar::clicked;call super::clicked;dw_mprimas.Retrieve(codigo_empresa,em_proveedor.text)
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_comprovmprima
integer x = 489
integer y = 292
integer width = 585
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION MATERIAS PRIMAS"
ue_datawindow = "dw_ayuda_venmprima"
ue_filtro     = "" 		
isle_campo = this
valor_empresa = TRUE

end event

event sle_valor::modificado;call super::modificado;st_nombremprima.text=f_nombre_mprima(codigo_empresa,sle_valor.text)

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_comprovmprima
integer x = 1925
integer y = 640
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_comprovmprima
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_comprovmprima
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_comprovmprima
end type

type st_2 from statictext within w_mant_comprovmprima
integer x = 142
integer y = 304
integer width = 311
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
string text = "Articulo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombremprima from statictext within w_mant_comprovmprima
integer x = 1097
integer y = 296
integer width = 896
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_mprimas from datawindow within w_mant_comprovmprima
integer x = 146
integer y = 752
integer width = 2190
integer height = 520
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_comprovmprima2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then return
sle_valor.text = f_valor_columna(dw_mprimas,row,"mprima")
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type em_proveedor from u_em_campo within w_mant_comprovmprima
integer x = 489
integer y = 180
integer width = 366
integer taborder = 10
end type

event getfocus;call super::getfocus;ue_titulo="AYUDA SELECCION DE PROVEEDORES"
ue_datawindow= "dw_ayuda_proveedores"
ue_filtro =""
isle_campo = this
valor_empresa = TRUE
end event

event modificado;call super::modificado;st_proveedor.text = f_nombre_proveedor(codigo_empresa,This.text)
iF Trim(st_proveedor.text) = "" Then
	IF Trim(em_proveedor.text)<>"" Then
	f_activar_campo(em_proveedor)
END IF
em_proveedor.text = ""
END iF
dw_mprimas.Retrieve(codigo_empresa,em_proveedor.text)

end event

type st_proveedor from statictext within w_mant_comprovmprima
integer x = 905
integer y = 172
integer width = 837
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

