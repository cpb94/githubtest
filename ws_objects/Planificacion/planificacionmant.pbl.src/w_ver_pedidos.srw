$PBExportHeader$w_ver_pedidos.srw
forward
global type w_ver_pedidos from window
end type
type dw_1 from datawindow within w_ver_pedidos
end type
end forward

global type w_ver_pedidos from window
integer x = 1056
integer y = 484
integer width = 6578
integer height = 1504
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 79741120
dw_1 dw_1
end type
global w_ver_pedidos w_ver_pedidos

on w_ver_pedidos.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_ver_pedidos.destroy
destroy(this.dw_1)
end on

event open;datawindow DW
string v_articulo, v_uso
long i
string encajados[]

DW = Message.PowerObjectParm

v_Articulo = DW.object.cod_articulo[dw.Getrow()]
v_uso = DW.object.articulos_uso[dw.Getrow()]

if v_uso = '3' then
	encajados[1] = v_articulo
end if


f_busca_encajados (v_articulo,  encajados)


//if upperbound(encajados) = 0 then
//	encajados[1] = v_articulo
//end if

Dw_1.SetTransObject(SQLCA)
dw_1.reset()
dw_1.retrieve (codigo_empresa, encajados)
dw_1.Sort()
dw_1.GroupCalc()



end event

type dw_1 from datawindow within w_ver_pedidos
integer x = 14
integer y = 16
integer width = 6519
integer height = 1388
integer taborder = 10
string dataobject = "dw_ver_pedidos"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;/*
long v_ot, fila_seleccionada
string cod_linea, linea

v_ot = w_ver_seleccion.dw_1.object.planificacion_ot[row]
linea = w_ver_seleccion.dw_1.object.prodlineas_resumido[row]

select codigo 
into :cod_linea
from prodlineas
where resumido = :linea
and empresa = :codigo_empresa;

w_planificacion.dw_1.retrieve(codigo_empresa,cod_linea)
fila_seleccionada = w_planificacion.dw_1.Find ("ot = "+string(v_ot), 1, w_planificacion.dw_1.RowCount() )
w_planificacion.dw_1.SelectRow ( fila_seleccionada, true )
w_planificacion.dw_1.ScrollToRow ( fila_seleccionada)
w_planificacion.sle_valor.text = cod_linea

w_planificacion.des_linea.text = linea

close(w_ver_seleccion)
*/
end event

