$PBExportHeader$w_con_prevision_metros_fabricar.srw
forward
global type w_con_prevision_metros_fabricar from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_prevision_metros_fabricar
end type
type cb_1 from commandbutton within w_con_prevision_metros_fabricar
end type
type pb_imprimir from upb_imprimir within w_con_prevision_metros_fabricar
end type
type dw_listado from datawindow within w_con_prevision_metros_fabricar
end type
type gb_5 from groupbox within w_con_prevision_metros_fabricar
end type
type gb_3 from groupbox within w_con_prevision_metros_fabricar
end type
type gb_2 from groupbox within w_con_prevision_metros_fabricar
end type
type em_fdesde from u_em_campo within w_con_prevision_metros_fabricar
end type
type em_fhasta from u_em_campo within w_con_prevision_metros_fabricar
end type
type gb_4 from groupbox within w_con_prevision_metros_fabricar
end type
type cb_2 from commandbutton within w_con_prevision_metros_fabricar
end type
type uo_seccion from u_marca_lista within w_con_prevision_metros_fabricar
end type
type dw_1 from datawindow within w_con_prevision_metros_fabricar
end type
type dw_metros_a_fabricar from datawindow within w_con_prevision_metros_fabricar
end type
end forward

global type w_con_prevision_metros_fabricar from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3840
integer height = 2568
string title = "Consulta de Movimientos"
string icon = "Application!"
pb_2 pb_2
cb_1 cb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
em_fdesde em_fdesde
em_fhasta em_fhasta
gb_4 gb_4
cb_2 cb_2
uo_seccion uo_seccion
dw_1 dw_1
dw_metros_a_fabricar dw_metros_a_fabricar
end type
global w_con_prevision_metros_fabricar w_con_prevision_metros_fabricar

type variables
boolean detalle = false
string ante_articulo
end variables

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)
dw_metros_a_fabricar.SetTransObject(sqlca)

This.title = "CONSULTA PREVISIÓN FABRICACIÓN (M2)"
istr_parametros = Message.PowerObjectParm

uo_seccion.f_cargar_datos("dw_ayuda_secciones","","","Sección","Descripción")


em_fdesde.text = string (today())
em_fhasta.text = string (RelativeDate ( today(), 7 ))
end event

on w_con_prevision_metros_fabricar.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.gb_4=create gb_4
this.cb_2=create cb_2
this.uo_seccion=create uo_seccion
this.dw_1=create dw_1
this.dw_metros_a_fabricar=create dw_metros_a_fabricar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.em_fdesde
this.Control[iCurrent+9]=this.em_fhasta
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.uo_seccion
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.dw_metros_a_fabricar
end on

on w_con_prevision_metros_fabricar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.gb_4)
destroy(this.cb_2)
destroy(this.uo_seccion)
destroy(this.dw_1)
destroy(this.dw_metros_a_fabricar)
end on

event activate;call super::activate;w_con_prevision_metros_fabricar = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_prevision_metros_fabricar
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_prevision_metros_fabricar
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_prevision_metros_fabricar
integer x = 14
integer y = 8
integer width = 3598
integer height = 88
end type

type pb_2 from upb_salir within w_con_prevision_metros_fabricar
integer x = 3621
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type cb_1 from commandbutton within w_con_prevision_metros_fabricar
integer x = 3159
integer y = 136
integer width = 411
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string   var_mp,secciones[]
datetime f_desde,f_hasta
long     indice,total,ind_array
uo_seccion.visible = false

f_desde = datetime(date(em_fdesde.text))
f_hasta = datetime(date(em_fhasta.text))

ind_array = 1
total     = uo_seccion.dw_marca.RowCount()
secciones = {""}

FOR indice = 1 To total
   IF uo_seccion.dw_marca.GetItemString(indice,"marca") = "S" THEN
		secciones[ind_array] = uo_seccion.dw_marca.GetItemString(indice,"codigo")
      ind_array ++
   END IF
NEXT

dw_1.retrieve(codigo_empresa,f_desde,f_hasta,secciones)



// Hacemos el informe con el nuevo sistema. Cuando este funcione, borraremos todo lo del anterior.

/*
long i, j, fila
datastore regs
string sel, s_secciones
string seccion, linea

s_secciones  = ''
for j = 1 to upperbound(secciones) - 1
	s_secciones = s_secciones + secciones [j] + ','
next

s_secciones = s_secciones + secciones[upperbound(secciones)]

sel = &
	" SELECT prodsecciones.descripcion_abr,   "+&
	"       prodlineas.codigo,   "+&
	"       formatos.largo,   "+&
	"       formatos.ancho,   "+&
	"       planificacion.cod_articulo,   "+&
	"       planificacion.fecha_fin,   "+&
	"       planificacion.cantidad  "+&
	"  FROM planificacion,   "+&
	"       prodlineas,   "+&
	"       prodsecciones,   "+&
	"       formatos  "+&
	" WHERE ( planificacion.empresa = prodlineas.empresa ) and  "+&
	"       ( prodlineas.empresa = prodsecciones.empresa ) and  "+&
	"       ( planificacion.lineaprod = prodlineas.codigo ) and  "+&
	"       ( prodlineas.seccion = prodsecciones.codigo ) and  "+&
	"       ( planificacion.empresa = formatos.empresa ) and  "+&
	"       ( planificacion.formato = formatos.codigo ) and  "+&
	"       ( planificacion.empresa = '"+codigo_empresa+"'  ) and  "+&
	"       ( planificacion.fecha_fin >= '"+string(f_desde)+"' ) and  "+&
	"       ( planificacion.fecha_fin <= '"+string(f_hasta)+"' ) and  "+&
	"       ( prodlineas.seccion in ("+s_secciones+") ) "
  
f_cargar_cursor_nuevo(sel, regs)

for i = 1 to regs.rowcount()
	fila = dw_metros_a_fabricar.insertrow(0)
	seccion = regs.object.prodsecciones_descripcion_abr[i]
	linea = regs.object.planificacion_cod_Articulo[i]
	dw_metros_a_fabricar.object.seccion[fila] = seccion
	dw_metros_a_fabricar.object.linea[fila] = linea
next

dw_metros_a_fabricar.setsort("")
dw_metros_a_fabricar.sort()

destroy regs
  
  
*/
end event

type pb_imprimir from upb_imprimir within w_con_prevision_metros_fabricar
integer x = 3589
integer y = 136
integer taborder = 0
boolean bringtotop = true
end type

event clicked;string   var_mp,tipos_mov[]
datetime f_desde,f_hasta
long     indice,total,ind_array
uo_seccion.visible = false

f_desde = datetime(date(em_fdesde.text))
f_hasta = datetime(date(em_fhasta.text))

ind_array = 1
total     = uo_seccion.dw_marca.RowCount()
tipos_mov = {""}

FOR indice = 1 To total
   IF uo_seccion.dw_marca.GetItemString(indice,"marca") = "S" THEN
		tipos_mov[ind_array] = uo_seccion.dw_marca.GetItemString(indice,"codigo")
      ind_array ++
   END IF
NEXT

dw_listado.retrieve(codigo_empresa,var_mp,f_desde,f_hasta,tipos_mov)

f_imprimir_datawindow(dw_listado)

end event

type dw_listado from datawindow within w_con_prevision_metros_fabricar
boolean visible = false
integer x = 1874
integer y = 12
integer width = 443
integer height = 140
integer taborder = 40
boolean bringtotop = true
string dataobject = "report_con_movimientos_mp"
boolean livescroll = true
end type

type gb_5 from groupbox within w_con_prevision_metros_fabricar
integer x = 2661
integer y = 100
integer width = 507
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_con_prevision_metros_fabricar
integer x = 3579
integer y = 96
integer width = 151
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_con_prevision_metros_fabricar
integer x = 3150
integer y = 96
integer width = 430
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_prevision_metros_fabricar
integer x = 46
integer y = 152
integer width = 357
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "$Œç<pïMˆïM"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_prevision_metros_fabricar
integer x = 416
integer y = 152
integer width = 357
integer taborder = 30
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = "˜"
boolean dropdowncalendar = true
end type

type gb_4 from groupbox within w_con_prevision_metros_fabricar
integer x = 23
integer y = 100
integer width = 782
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within w_con_prevision_metros_fabricar
integer x = 2688
integer y = 136
integer width = 457
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Secciones"
end type

event clicked;uo_seccion.visible = not(uo_seccion.visible)

end event

type uo_seccion from u_marca_lista within w_con_prevision_metros_fabricar
boolean visible = false
integer x = 1166
integer y = 284
integer width = 1358
integer height = 664
integer taborder = 50
end type

on uo_seccion.destroy
call u_marca_lista::destroy
end on

type dw_1 from datawindow within w_con_prevision_metros_fabricar
integer x = 5
integer y = 272
integer width = 3758
integer height = 2052
string dataobject = "dw_con_prevision_metros_fabricar"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;if detalle then
	this.modify("datawindow.detail.height = 0")
	dw_listado.modify("datawindow.detail.height = 0")
else	
	this.modify("datawindow.detail.height = 68")
	dw_listado.modify("datawindow.detail.height = 68")
end if
detalle = not(detalle)
end event

type dw_metros_a_fabricar from datawindow within w_con_prevision_metros_fabricar
integer x = 5
integer y = 272
integer width = 3758
integer height = 2052
integer taborder = 30
string dataobject = "dw_metros_a_fabricar"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;if detalle then
	this.modify("datawindow.detail.height = 0")
	dw_listado.modify("datawindow.detail.height = 0")
else	
	this.modify("datawindow.detail.height = 68")
	dw_listado.modify("datawindow.detail.height = 68")
end if
detalle = not(detalle)
end event

