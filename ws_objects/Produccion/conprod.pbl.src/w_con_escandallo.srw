$PBExportHeader$w_con_escandallo.srw
forward
global type w_con_escandallo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_escandallo
end type
type st_1 from statictext within w_con_escandallo
end type
type uo_articulo from u_em_campo_2 within w_con_escandallo
end type
type tv_escandallo from treeview within w_con_escandallo
end type
type cb_1 from commandbutton within w_con_escandallo
end type
type pb_2 from picturebutton within w_con_escandallo
end type
type cb_2 from commandbutton within w_con_escandallo
end type
type st_texto from statictext within w_con_escandallo
end type
end forward

global type w_con_escandallo from w_int_con_empresa
integer x = 14
integer y = 4
integer width = 3342
integer height = 2248
pb_1 pb_1
st_1 st_1
uo_articulo uo_articulo
tv_escandallo tv_escandallo
cb_1 cb_1
pb_2 pb_2
cb_2 cb_2
st_texto st_texto
end type
global w_con_escandallo w_con_escandallo

on w_con_escandallo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_articulo=create uo_articulo
this.tv_escandallo=create tv_escandallo
this.cb_1=create cb_1
this.pb_2=create pb_2
this.cb_2=create cb_2
this.st_texto=create st_texto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_articulo
this.Control[iCurrent+4]=this.tv_escandallo
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_texto
end on

on w_con_escandallo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_articulo)
destroy(this.tv_escandallo)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.cb_2)
destroy(this.st_texto)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta Escandallo"
This.title                       =   istr_parametros.s_titulo_ventana

f_activar_campo(uo_articulo.em_campo)

if nombre_usuario = 'TENCER' or nombre_usuario = 'PTENCER' then
	cb_2.visible = true
else
		cb_2.visible = false
end if
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_escandallo
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_escandallo
integer width = 334
end type

event sle_opcion_orden::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_escandallo
integer width = 3223
integer height = 84
boolean italic = true
end type

type pb_1 from upb_salir within w_con_escandallo
integer x = 3109
integer y = 148
integer width = 123
integer height = 108
integer taborder = 0
end type

type st_1 from statictext within w_con_escandallo
integer x = 91
integer y = 188
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Articulo"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_con_escandallo
integer x = 398
integer y = 176
integer width = 846
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

event modificado;uo_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	Return
end if 

end event

type tv_escandallo from treeview within w_con_escandallo
integer x = 50
integer y = 280
integer width = 3209
integer height = 1704
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
string picturename[] = {"Custom039!","Next!","VCRNext!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

type cb_1 from commandbutton within w_con_escandallo
integer x = 2615
integer y = 156
integer width = 325
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;integer nodo
if uo_articulo.em_codigo.text <> "" then
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(uo_Articulo.em_codigo.text, 0, tv_escandallo)
end if
end event

type pb_2 from picturebutton within w_con_escandallo
integer x = 2971
integer y = 156
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
string picturename = "print!"
alignment htextalign = left!
end type

event clicked;long Job

Job = PrintOpen( )
Print(Job, "ESTRUCTURA DE ARTÍCULO")
PrintDefineFont(Job, 1, "Decorative", -18, 400, Default!, Decorative!, true, true) 
tv_escandallo.Print(Job, 0, PrintY(Job)+500)

PrintClose(Job)


end event

type cb_2 from commandbutton within w_con_escandallo
boolean visible = false
integer x = 1989
integer y = 1756
integer width = 887
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Proceso"
end type

event clicked;
long n
string sel, v_articulo, v_version, v_operacion, articulo_op
datastore registros
boolean fallo

st_texto.visible = true

sel = " select articulo, version, operacion "+&
" from art_ver_op_aplicaciones " 
//" where articulo = '2765' "+&
//" or articulo = '2711' "+&
//" or articulo = '2710' "

f_cargar_cursor_nuevo (sel, registros)


fallo = false
for n = 1 to registros.rowcount() 
	v_articulo = registros.object.articulo[n]
	v_version = registros.object.version[n]
	v_operacion = registros.object.operacion[n]

//	articulo_op = datos.object.art_ver_operaciones_articulo[i]
	
	articulo_op = ''
	select articulo
	into :articulo_op
	from art_ver_operaciones
	where articulo = :v_articulo
	and version = :v_version
	and operacion = :v_operacion;

	if articulo_op = '' then
		connect using SQLCA;

		delete from art_ver_op_aplicaciones
		where empresa = :codigo_empresa
		and articulo = :v_articulo
		and version = :v_version
		and operacion = :v_operacion;	
		if SQLCA.SQLCode = -1 then
			rollback using SQLCA;
			messagebox ("Error", "Error borrando aplicaciones en artículo = "+v_Articulo)
		else
			commit using SQLCA;
		end if
	end if	
	

	st_texto.text = string(n)+" de " +string (registros.rowcount())
next
st_texto.visible = false

end event

type st_texto from statictext within w_con_escandallo
boolean visible = false
integer x = 1623
integer y = 140
integer width = 713
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

