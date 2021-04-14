$PBExportHeader$w_mant_cuenta_resultados_mini.srw
forward
global type w_mant_cuenta_resultados_mini from w_mant_grid
end type
end forward

global type w_mant_cuenta_resultados_mini from w_mant_grid
integer width = 3342
integer height = 1796
end type
global w_mant_cuenta_resultados_mini w_mant_cuenta_resultados_mini

on w_mant_cuenta_resultados_mini.create
call super::create
end on

on w_mant_cuenta_resultados_mini.destroy
call super::destroy
end on

event open;call super::open;
this.title = "Mantenimiento Cuenta de Resultados (Cuadro de Mando) "
dw_datos.retrieve()
end event

type pb_salir from w_mant_grid`pb_salir within w_mant_cuenta_resultados_mini
end type

type pb_borrar from w_mant_grid`pb_borrar within w_mant_cuenta_resultados_mini
end type

type pb_nuevo from w_mant_grid`pb_nuevo within w_mant_cuenta_resultados_mini
end type

type pb_grabar from w_mant_grid`pb_grabar within w_mant_cuenta_resultados_mini
integer x = 2853
end type

event pb_grabar::clicked;call super::clicked;commit using sqlca;
end event

type st_titulo from w_mant_grid`st_titulo within w_mant_cuenta_resultados_mini
integer width = 2624
integer weight = 700
end type

type dw_datos from w_mant_grid`dw_datos within w_mant_cuenta_resultados_mini
integer width = 3237
integer height = 1528
string dataobject = "dw_mant_cuenta_resultados_mini"
end type

