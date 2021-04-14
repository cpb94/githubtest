$PBExportHeader$w_traspaso_partes.srw
forward
global type w_traspaso_partes from w_int_con_empresa
end type
type pb_1 from upb_salir within w_traspaso_partes
end type
type st_1 from statictext within w_traspaso_partes
end type
type uo_articulo from u_em_campo_2 within w_traspaso_partes
end type
type cb_consulta from commandbutton within w_traspaso_partes
end type
type dw_origen from datawindow within w_traspaso_partes
end type
type dw_destino from datawindow within w_traspaso_partes
end type
type cb_procesar from commandbutton within w_traspaso_partes
end type
type st_2 from statictext within w_traspaso_partes
end type
type sle_articulo_dest from singlelineedit within w_traspaso_partes
end type
end forward

global type w_traspaso_partes from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 2519
integer height = 1652
pb_1 pb_1
st_1 st_1
uo_articulo uo_articulo
cb_consulta cb_consulta
dw_origen dw_origen
dw_destino dw_destino
cb_procesar cb_procesar
st_2 st_2
sle_articulo_dest sle_articulo_dest
end type
global w_traspaso_partes w_traspaso_partes

on w_traspaso_partes.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_articulo=create uo_articulo
this.cb_consulta=create cb_consulta
this.dw_origen=create dw_origen
this.dw_destino=create dw_destino
this.cb_procesar=create cb_procesar
this.st_2=create st_2
this.sle_articulo_dest=create sle_articulo_dest
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_articulo
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.dw_origen
this.Control[iCurrent+6]=this.dw_destino
this.Control[iCurrent+7]=this.cb_procesar
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.sle_articulo_dest
end on

on w_traspaso_partes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_articulo)
destroy(this.cb_consulta)
destroy(this.dw_origen)
destroy(this.dw_destino)
destroy(this.cb_procesar)
destroy(this.st_2)
destroy(this.sle_articulo_dest)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Traspaso Partes"
This.title                       =   istr_parametros.s_titulo_ventana

f_activar_campo(uo_articulo.em_campo)

dw_origen.SettransObject (SQLCA)
dw_destino.SettransObject (SQLCA)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_traspaso_partes
integer x = 320
integer y = 1376
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_traspaso_partes
integer width = 334
end type

event sle_opcion_orden::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_traspaso_partes
integer x = 23
integer width = 2286
integer height = 84
boolean italic = true
end type

type pb_1 from upb_salir within w_traspaso_partes
integer x = 2322
integer y = 120
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type st_1 from statictext within w_traspaso_partes
integer x = 18
integer y = 136
integer width = 251
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = right!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_traspaso_partes
integer x = 279
integer y = 128
integer width = 827
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Familias"
ue_datawindow ="dw_ayuda_articulos"
ue_filtro = ""
end event

event modificado;uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa, uo_articulo.em_codigo.text)
sle_articulo_dest.text = uo_articulo.em_codigo.text

If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 

end event

type cb_consulta from commandbutton within w_traspaso_partes
integer x = 1806
integer y = 124
integer width = 247
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;dw_origen.retrieve (codigo_empresa, uo_articulo.em_codigo.text)
dw_destino.retrieve (codigo_empresa, uo_articulo.em_codigo.text)
end event

type dw_origen from datawindow within w_traspaso_partes
integer x = 46
integer y = 252
integer width = 1061
integer height = 1116
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_partes_operaciones_origen"
boolean border = false
boolean livescroll = true
end type

type dw_destino from datawindow within w_traspaso_partes
integer x = 1376
integer y = 252
integer width = 1061
integer height = 1116
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_con_partes_operaciones_destino"
boolean border = false
boolean livescroll = true
end type

event retrieveend;long i
string operacion_dest

for i = 1 to dw_destino.rowcount()
	operacion_dest = dw_destino.object.prodpartes_ot_operacion[i]

	if operacion_dest = '10' then
		dw_destino.object.prodpartes_ot_operacion[i] = '5'
		dw_destino.object.art_ver_tipooperacion_descripcion_abr[i] = 'CORT'
	end if
	if operacion_dest = '8' then
		dw_destino.object.prodpartes_ot_operacion[i] = '3'
		dw_destino.object.art_ver_tipooperacion_descripcion_abr[i] = 'HORN'
	end if
	if operacion_dest = '19' then
		dw_destino.object.prodpartes_ot_operacion[i] = '26'
		dw_destino.object.art_ver_tipooperacion_descripcion_abr[i] = 'ENCR'
	end if
	
	dw_destino.object.prodpartes_ot_articulo[i] = sle_articulo_dest.text

next
end event

type cb_procesar from commandbutton within w_traspaso_partes
integer x = 2062
integer y = 124
integer width = 247
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;string articulo_or, articulo_dest, operacion_or, operacion_dest
long orden_or, orden_dest
integer i
boolean exito

dw_destino.AcceptText()

exito = true
for i = 1 to dw_destino.rowcount()
	if isnull(dw_destino.object.prodpartes_ot_articulo[i]) then
		articulo_dest = ''
	else
		articulo_dest = dw_destino.object.prodpartes_ot_articulo[i]
	end if
	if articulo_dest <> '' then
		orden_dest = dw_destino.object.prodpartes_ot_ordenoperacion[i]
		operacion_dest = dw_destino.object.prodpartes_ot_operacion[i]

		articulo_or = dw_origen.object.prodpartes_ot_articulo[i]
		orden_or = dw_origen.object.prodpartes_ot_ordenoperacion[i]
		operacion_or = dw_origen.object.prodpartes_ot_operacion[i]
		
		connect using SQLCA;
		update prodpartes_ot set articulo = :articulo_dest, ordenoperacion = :orden_dest, operacion = :operacion_dest
		where empresa = :codigo_empresa
		and articulo = :articulo_or
		and ordenoperacion = :orden_or
		and operacion = :operacion_or;
		
		
		if SQLCA.SQLCode = -1 then
			exito = false		
		end if
	end if
	f_mensaje_proceso("Registro", i, dw_destino.rowcount())
next

if exito = true then
	commit using SQLCA;
	messagebox ("Aviso", "Traspaso finalizado con éxito.")
else
	rollback using SQLCA;
	messagebox ("Error", "El traspaso no se llevó a cabo debido al error: "+ SQLCA.SQLErrtext )

end if



end event

type st_2 from statictext within w_traspaso_partes
integer x = 1143
integer y = 136
integer width = 347
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo dest:"
alignment alignment = right!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type sle_articulo_dest from singlelineedit within w_traspaso_partes
integer x = 1504
integer y = 124
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

