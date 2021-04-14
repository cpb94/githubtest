$PBExportHeader$w_contabilidad_vs_cartera_pagos.srw
forward
global type w_contabilidad_vs_cartera_pagos from wt_consultas_padre
end type
type cbx_dif from checkbox within w_contabilidad_vs_cartera_pagos
end type
end forward

global type w_contabilidad_vs_cartera_pagos from wt_consultas_padre
string title = "Contabilidad vs Cartera Pagos"
cbx_dif cbx_dif
end type
global w_contabilidad_vs_cartera_pagos w_contabilidad_vs_cartera_pagos

event open;call super::open;dw_datos.SettransObject(SQLCA)
dw_datos.retrieve (codigo_empresa, year(today()))

dw_datos.SetFilter("saldo <> 0 or cartera2 <> 0 ")
dw_datos.filter ()
end event

on w_contabilidad_vs_cartera_pagos.create
int iCurrent
call super::create
this.cbx_dif=create cbx_dif
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_dif
end on

on w_contabilidad_vs_cartera_pagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_dif)
end on

type pb_imprimir from wt_consultas_padre`pb_imprimir within w_contabilidad_vs_cartera_pagos
integer x = 3977
end type

type pb_borrar from wt_consultas_padre`pb_borrar within w_contabilidad_vs_cartera_pagos
boolean visible = false
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within w_contabilidad_vs_cartera_pagos
boolean visible = false
integer x = 41
integer y = 272
end type

type pb_1 from wt_consultas_padre`pb_1 within w_contabilidad_vs_cartera_pagos
boolean visible = false
end type

type pb_reset from wt_consultas_padre`pb_reset within w_contabilidad_vs_cartera_pagos
boolean visible = false
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within w_contabilidad_vs_cartera_pagos
boolean visible = false
end type

type ddlb_operador from wt_consultas_padre`ddlb_operador within w_contabilidad_vs_cartera_pagos
boolean visible = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within w_contabilidad_vs_cartera_pagos
boolean visible = false
end type

type dw_datos from wt_consultas_padre`dw_datos within w_contabilidad_vs_cartera_pagos
integer x = 55
integer y = 252
integer height = 2376
string dataobject = "dw_contabilidad_vs_cartera_pagos"
end type

type pb_salir from wt_consultas_padre`pb_salir within w_contabilidad_vs_cartera_pagos
end type

type st_titulo from wt_consultas_padre`st_titulo within w_contabilidad_vs_cartera_pagos
end type

type p_logo from wt_consultas_padre`p_logo within w_contabilidad_vs_cartera_pagos
end type

type dw_filtro from wt_consultas_padre`dw_filtro within w_contabilidad_vs_cartera_pagos
end type

type pb_buscar from wt_consultas_padre`pb_buscar within w_contabilidad_vs_cartera_pagos
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within w_contabilidad_vs_cartera_pagos
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within w_contabilidad_vs_cartera_pagos
end type

type sle_texto from wt_consultas_padre`sle_texto within w_contabilidad_vs_cartera_pagos
end type

type lb_lista from wt_consultas_padre`lb_lista within w_contabilidad_vs_cartera_pagos
end type

type cbx_dif from checkbox within w_contabilidad_vs_cartera_pagos
integer x = 2843
integer y = 136
integer width = 960
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar con Diferencia <> 0"
end type

event clicked;if cbx_dif.checked then
	dw_Datos.setfilter ("diferencia <> 0")
else
	dw_datos.SetFilter("saldo <> 0 or cartera2 <> 0 ")
end if

dw_Datos.filter()
end event

