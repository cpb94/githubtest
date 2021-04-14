$PBExportHeader$w_con_formulas_mat_prima.srw
forward
global type w_con_formulas_mat_prima from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_formulas_mat_prima
end type
type st_1 from statictext within w_con_formulas_mat_prima
end type
type dw_1 from datawindow within w_con_formulas_mat_prima
end type
type dw_listado from datawindow within w_con_formulas_mat_prima
end type
type pb_imprimir from upb_imprimir within w_con_formulas_mat_prima
end type
type uo_1 from u_em_campo_2 within w_con_formulas_mat_prima
end type
type cb_1 from u_boton within w_con_formulas_mat_prima
end type
type st_2 from statictext within w_con_formulas_mat_prima
end type
type uo_2 from u_em_campo_2 within w_con_formulas_mat_prima
end type
type cb_2 from commandbutton within w_con_formulas_mat_prima
end type
type st_3 from statictext within w_con_formulas_mat_prima
end type
type uo_proveedor from u_em_campo_2 within w_con_formulas_mat_prima
end type
end forward

global type w_con_formulas_mat_prima from w_int_con_empresa
integer x = 27
integer y = 16
integer width = 3282
integer height = 3368
pb_1 pb_1
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_1 uo_1
cb_1 cb_1
st_2 st_2
uo_2 uo_2
cb_2 cb_2
st_3 st_3
uo_proveedor uo_proveedor
end type
global w_con_formulas_mat_prima w_con_formulas_mat_prima

on w_con_formulas_mat_prima.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_1=create uo_1
this.cb_1=create cb_1
this.st_2=create st_2
this.uo_2=create uo_2
this.cb_2=create cb_2
this.st_3=create st_3
this.uo_proveedor=create uo_proveedor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.uo_2
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.uo_proveedor
end on

on w_con_formulas_mat_prima.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.uo_2)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.uo_proveedor)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Fórmulas por Materia Prima"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_listado.SetTransObject(SQLCA)

f_activar_campo(uo_1.em_campo)
end event

event ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;string formula

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
//	f_activar_campo(uo_1.em_campo)
//	return
	formula = "%"
else
	uo_1.em_codigo.text = uo_1.em_codigo.text
end if
dw_listado.Retrieve(codigo_empresa,uo_1.em_codigo.text)
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_formulas_mat_prima
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_formulas_mat_prima
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_formulas_mat_prima
integer x = 18
integer y = 32
integer width = 3186
end type

type pb_1 from upb_salir within w_con_formulas_mat_prima
integer x = 3040
integer y = 164
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\BMP\Log Out_24x24.png"
end type

type st_1 from statictext within w_con_formulas_mat_prima
integer x = 247
integer y = 176
integer width = 347
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Mat. Prima:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_formulas_mat_prima
integer x = 55
integer y = 468
integer width = 3154
integer height = 2716
boolean bringtotop = true
string dataobject = "dw_con_formulas_mat_prima"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked; str_parametros lstr_param 
  lstr_param.i_nargumentos=2
  lstr_param.s_argumentos[1]="proddetformula_formulacion"
  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"proddetformula_formulacion"))
  OpenWithParm(wi_mant_formulaciones,lstr_param)

end event

type dw_listado from datawindow within w_con_formulas_mat_prima
boolean visible = false
integer width = 521
integer height = 208
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_formatos_articulos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_formulas_mat_prima
event clicked pbm_bnclicked
integer x = 2871
integer y = 164
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\bmp\printer-icon2_24x24.png"
end type

event clicked;//if trim( uo_1.em_codigo.text)= "" Then
//	  f_mensaje("No se puede procesar el listado"," Introduzca el formato")
//	  Return
//END IF


Parent.triggerEvent("ue_listar")
f_activar_campo(uo_1.em_campo)
end event

type uo_1 from u_em_campo_2 within w_con_formulas_mat_prima
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 603
integer y = 172
integer width = 1262
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;string des_mprima

select descripcion
into :des_mprima
from venmprima
where empresa = :codigo_empresa
and  codigo = :uo_1.em_codigo.text;

uo_1.em_campo.text = des_mprima
If Trim(uo_1.em_campo.text) = "" then
	uo_1.em_campo.text = ""
	uo_1.em_codigo.text = ""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Materias primas"
ue_datawindow ="dw_ayuda_venmprima"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cb_1 from u_boton within w_con_formulas_mat_prima
integer x = 1897
integer y = 164
integer width = 325
integer height = 92
integer taborder = 50
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;string mprima

if IsNull(uo_1.em_codigo.text) or Trim(uo_1.em_codigo.text) = "" then
//	f_mensaje("Consulta de Artículos","Introduzca el formato")
//	f_activar_campo(uo_1.em_campo)
//	return
	mprima = "%"
else
	mprima = uo_1.em_codigo.text
end if

dw_1.Retrieve(codigo_empresa,mprima)

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if
end event

type st_2 from statictext within w_con_formulas_mat_prima
integer x = 14
integer y = 256
integer width = 581
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Mat. Prima Destino:"
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_2 from u_em_campo_2 within w_con_formulas_mat_prima
event destroy ( )
integer x = 599
integer y = 260
integer width = 1262
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_2.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_mprima

select descripcion
into :des_mprima
from venmprima
where empresa = :codigo_empresa
and  codigo = :uo_2.em_codigo.text;

uo_2.em_campo.text = des_mprima
If Trim(uo_2.em_campo.text) = "" then
	uo_2.em_campo.text = ""
	uo_2.em_codigo.text = ""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Materias primas"
ue_datawindow ="dw_ayuda_venmprima"
ue_filtro = ""
end event

type cb_2 from commandbutton within w_con_formulas_mat_prima
integer x = 1893
integer y = 260
integer width = 325
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Traspaso"
end type

event clicked;long i
decimal v_cantidad, v_cantidad_u_m_mp
string v_unidadmedida, v_unidad_u_m_mp, v_formulacion, v_proveedor, v_mp
boolean bien = true

IF MessageBox("Cuidado", "¡¡¡¡¡¡¡¡¡¡ "+nombre_usuario+" !!!!!!!!!!~nLa materia prima "+uo_1.em_codigo.text+&
			" va a ser sustituída por "+uo_2.em_codigo.text+". ~n¿Desea continuar?", &
			Information! , YesNo!, 2) = 1 THEN
	IF MessageBox("Cuidado", nombre_usuario+" ......~n¿Seguro que quieres continuar?",	StopSign!, YesNo!, 2) = 1 THEN	
		connect using SQLCA;
		FOR i = 1 TO dw_1.RowCount() 
			v_formulacion = dw_1.object.proddetformula_formulacion[i]
			v_proveedor = dw_1.object.proddetformula_proveedor[i]
			v_mp = dw_1.object.proddetformula_mp[i]
			
			select cantidad, unidadmedida, cantidad_u_m_mp, unidad_u_m_mp
			into :v_cantidad, :v_unidadmedida, :v_cantidad_u_m_mp, :v_unidad_u_m_mp
			from proddetformula 
			where empresa = :codigo_empresa
			and formulacion = :v_formulacion
			and proveedor = :v_proveedor
			and mp = :v_mp;
			
			IF SQLCA.SQLCode <> 0 THEN 
				bien = false
			end if
			
			delete from proddetformula 
			where empresa = :codigo_empresa
			and formulacion = :v_formulacion
			and proveedor = :v_proveedor
			and mp = :v_mp;
			
			IF SQLCA.SQLCode <> 0 THEN 
				bien = false
			end if
		
			if uo_proveedor.em_codigo.text <> '' or not isnull(uo_proveedor.em_codigo.text) then
				v_proveedor = uo_proveedor.em_codigo.text
			end if
			insert into proddetformula (mp, empresa, formulacion, proveedor, cantidad, unidadmedida, cantidad_u_m_mp, unidad_u_m_mp)
			values (:uo_2.em_codigo.text, :codigo_empresa, :v_formulacion, :v_proveedor, 
						:v_cantidad, :v_unidadmedida, :v_cantidad_u_m_mp, :v_unidad_u_m_mp);
						
			IF SQLCA.SQLCode <> 0 THEN 
				bien = false
			end if
			
			f_mensaje_proceso("Sustituyendo", i, dw_1.Rowcount())
		NEXT
		if bien then
			commit using SQLCA;
		else
			rollback using SQLCA;
		end if

	END IF			
END IF

//cb_1.triggerEvent("clicked")


end event

type st_3 from statictext within w_con_formulas_mat_prima
integer x = 23
integer y = 344
integer width = 571
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor:"
alignment alignment = right!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_con_formulas_mat_prima
event destroy ( )
integer x = 599
integer y = 348
integer width = 1262
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;string proveedor

select razon
into :proveedor
from genter
where empresa = :codigo_empresa
and tipoter = 'P'
and  codigo = :uo_proveedor.em_codigo.text;

uo_proveedor.em_campo.text = proveedor
If Trim(uo_proveedor.em_campo.text) = "" then
	uo_proveedor.em_campo.text = ""
	uo_proveedor.em_codigo.text = ""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"
ue_filtro = ""
end event

