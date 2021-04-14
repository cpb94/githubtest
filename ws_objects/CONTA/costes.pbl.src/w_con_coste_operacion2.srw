$PBExportHeader$w_con_coste_operacion2.srw
forward
global type w_con_coste_operacion2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_coste_operacion2
end type
type pb_2 from upb_imprimir within w_con_coste_operacion2
end type
type cb_1 from commandbutton within w_con_coste_operacion2
end type
type gb_1 from groupbox within w_con_coste_operacion2
end type
type gb_6 from groupbox within w_con_coste_operacion2
end type
type dw_informe from datawindow within w_con_coste_operacion2
end type
type em_fdesde from u_em_campo within w_con_coste_operacion2
end type
type em_fhasta from u_em_campo within w_con_coste_operacion2
end type
type st_contador from statictext within w_con_coste_operacion2
end type
end forward

global type w_con_coste_operacion2 from w_int_con_empresa
integer x = 5
integer y = 32
integer width = 3790
integer height = 3448
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
st_contador st_contador
end type
global w_con_coste_operacion2 w_con_coste_operacion2

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Datetime  fecha1,fecha2
string sel
long actual, i, total_registros
datastore ds_operaciones
string v_articulo, v_version, v_operacion, anyo_Ant, v_seccion, v_seccion_anterior, v_cod_seccion
dec v_piezas, v_buenas, v_malas
dec v_coste_fab, v_coste_mp, v_horas, v_coste_fab_malas, v_coste_mp_malas
dec v_coste_mermas_fab, v_coste_mermas_mp

st_contador.visible = true

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

data.setredraw(false)		
fecha1 = datetime(em_fdesde.text)
fecha2 = datetime(em_fhasta.text)


anyo_ant = string(RelativeDate(date(fecha2), -365))

data.reset()
data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text

sel = " select 	p.articulo, p.version, p.operacion, p.ordenoperacion, "+&
		" ( p.buenas + p.malas ) as piezas, ( p.buenas)  as buenas, ( p.malas)  as malas, p.seccion, "+&
		" t.velocidad_Std , t.descripcion_abr, o.coste_mp, o.coste_fab,  (o.coste_fab_mermas ) as coste_fab_mermas , (o.coste_mp_mermas )as coste_mp_mermas, "+&
		" s.descripcion_abr "+&
		" from prodpartes_ot p, "+&
		" art_ver_tipooperacion t, "+&
		" art_ver_operaciones o, "+&
		" prodsecciones s "+&
		" where p.empresa = '"+codigo_empresa+"'"+&
		" and t.empresa = '"+codigo_empresa+"'"+&
		" and o.empresa = '"+codigo_empresa+"'"+&
		" and s.empresa = '"+codigo_empresa+"'"+&
		" and p.fecha >= '"+em_fdesde.text+"'"+&
		" and p.fecha <= '"+em_fhasta.text+"'"+&
		" and p.operacion = t.codigo "+&
		" and p.seccion <> '8' "+&
		" and p.articulo = o.articulo "+&
		" and p.version = o.version "+&
  		" and p.ordenoperacion = o.orden "+&
		" and p.seccion = s.codigo "+&
		" order by convert(integer, p.operacion) "

st_contador.text = " Cargando Registros. "
f_cargar_cursor_nuevo(sel, ds_operaciones)

total_registros = ds_operaciones.rowcount() 
v_seccion_anterior = ''
for i = 1 to total_registros 
	v_articulo = ds_operaciones.object.prodpartes_ot_articulo[i]
	v_version = ds_operaciones.object.prodpartes_ot_version[i]
	v_operacion = ds_operaciones.object.prodpartes_ot_operacion[i]
	v_piezas = ds_operaciones.object.piezas[i]
	v_buenas = ds_operaciones.object.buenas[i]
	v_malas =  ds_operaciones.object.malas[i]
	v_seccion = ds_operaciones.object.prodsecciones_descripcion_abr[i]
	v_cod_seccion = ds_operaciones.object.prodpartes_ot_seccion[i]
	v_coste_mermas_fab = ds_operaciones.object.coste_fab_mermas[i]
	v_coste_mermas_mp = ds_operaciones.object.coste_mp_mermas[i]
	
	if v_seccion <> v_seccion_anterior then
		select sum (horas) 
		into :v_horas
		from prodmeses, prodlineas
		where prodlineas.empresa = :codigo_empresa
		and prodmeses.empresa = :codigo_empresa
		and prodlineas.calendario = prodmeses.calendario
		and fecha >= :fecha1
		and fecha <= :fecha2
		and seccion = :v_cod_seccion;

	else
		
	end if
	v_seccion_anterior = v_seccion
	
	// Cáclulo del coste de fabricación
	if isnull(ds_operaciones.object.art_ver_operaciones_coste_fab[i]) then
		v_coste_fab = 0 
	else
		if v_cod_seccion = '3' then // Hornos
			v_coste_fab = ds_operaciones.object.art_ver_operaciones_coste_fab[i] * v_buenas
		else
			v_coste_fab = ds_operaciones.object.art_ver_operaciones_coste_fab[i] * v_buenas
		end if
	end if
	if isnull(ds_operaciones.object.coste_fab_mermas[i]) then
		v_coste_mermas_fab = 0
	else
		v_coste_mermas_fab = ds_operaciones.object.coste_fab_mermas[i] * v_buenas
	end if
	
	
	// Cálculo del coste de MP
	if isnull(ds_operaciones.object.art_ver_operaciones_coste_mp[i]) then
		v_coste_mp = 0
	else
		v_coste_mp = ds_operaciones.object.art_ver_operaciones_coste_mp[i] * v_piezas
	end if
	if isnull(ds_operaciones.object.coste_mp_mermas[i]) then
		v_coste_mermas_mp = 0
	else
		v_coste_mermas_mp = ds_operaciones.object.coste_mp_mermas[i] * v_buenas
	end if


	actual = data.insertrow(0)

	data.object.operacion[actual] = ds_operaciones.object.art_ver_tipooperacion_descripcion_abr[i]
	data.object.coste_fab[actual] = v_coste_fab
	data.object.coste_mp[actual] = v_coste_mp
	data.object.coste_tot[actual] = v_coste_fab + v_coste_mp
	data.object.seccion[actual] = v_seccion
	data.object.horas[actual] = v_horas
	data.object.malas[actual] = ( v_coste_mermas_fab + v_coste_mermas_mp ) // v_coste_fab_malas + v_coste_mp_malas

	st_contador.text = "Registro: "+string(i, "###,###,###,###,##0")+" de "+string(total_registros, "###,###,###,###,##0")
next

destroy ds_operaciones

st_contador.visible = false
data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe Coste Fabricación Imputado por Operación"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-09-01"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_con_coste_operacion2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.st_contador=create st_contador
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.st_contador
end on

on w_con_coste_operacion2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.st_contador)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_coste_operacion2
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_coste_operacion2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_coste_operacion2
integer y = 8
integer width = 3685
integer height = 88
end type

type pb_1 from upb_salir within w_con_coste_operacion2
integer x = 3538
integer y = 140
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_coste_operacion2
integer x = 3419
integer y = 140
integer taborder = 0
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_coste_operacion2
integer x = 3122
integer y = 140
integer width = 288
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_coste_operacion2
integer x = 82
integer y = 100
integer width = 617
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_6 from groupbox within w_con_coste_operacion2
integer x = 3104
integer y = 100
integer width = 571
integer height = 152
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_con_coste_operacion2
integer x = 46
integer y = 264
integer width = 3666
integer height = 2952
boolean bringtotop = true
string dataobject = "dw_con_coste_operacion2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type em_fdesde from u_em_campo within w_con_coste_operacion2
integer x = 96
integer y = 160
integer width = 288
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_coste_operacion2
integer x = 393
integer y = 160
integer width = 288
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_contador from statictext within w_con_coste_operacion2
boolean visible = false
integer x = 1257
integer y = 180
integer width = 1047
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

