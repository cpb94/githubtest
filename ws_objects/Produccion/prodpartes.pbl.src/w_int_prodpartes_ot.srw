$PBExportHeader$w_int_prodpartes_ot.srw
forward
global type w_int_prodpartes_ot from w_int_con_empresa
end type
type st_turno from statictext within w_int_prodpartes_ot
end type
type pb_1 from upb_salir within w_int_prodpartes_ot
end type
type st_fecha from statictext within w_int_prodpartes_ot
end type
type em_fecha from u_em_campo within w_int_prodpartes_ot
end type
type st_operario from statictext within w_int_prodpartes_ot
end type
type uo_operario from u_em_campo_2 within w_int_prodpartes_ot
end type
type ddlb_turnos from dropdownlistbox within w_int_prodpartes_ot
end type
type cb_insertar from u_boton within w_int_prodpartes_ot
end type
type cb_borrar from u_boton within w_int_prodpartes_ot
end type
type cb_grabar from u_boton within w_int_prodpartes_ot
end type
type r_1 from rectangle within w_int_prodpartes_ot
end type
type st_linea from statictext within w_int_prodpartes_ot
end type
type uo_linea from u_em_campo_2 within w_int_prodpartes_ot
end type
type dw_3 from datawindow within w_int_prodpartes_ot
end type
type p_1 from picture within w_int_prodpartes_ot
end type
type st_5 from statictext within w_int_prodpartes_ot
end type
type st_seccion from statictext within w_int_prodpartes_ot
end type
type dw_2 from u_datawindow_consultas within w_int_prodpartes_ot
end type
type dw_1 from u_datawindow_consultas_2_criterios within w_int_prodpartes_ot
end type
type cb_importar from commandbutton within w_int_prodpartes_ot
end type
type p_flecha from picture within w_int_prodpartes_ot
end type
type cb_1 from commandbutton within w_int_prodpartes_ot
end type
type dw_4 from u_datawindow_consultas within w_int_prodpartes_ot
end type
type r_2 from rectangle within w_int_prodpartes_ot
end type
end forward

global type w_int_prodpartes_ot from w_int_con_empresa
integer x = 0
integer y = 0
integer width = 4672
integer height = 3628
string icon = "\bmp\RINO.ICO"
st_turno st_turno
pb_1 pb_1
st_fecha st_fecha
em_fecha em_fecha
st_operario st_operario
uo_operario uo_operario
ddlb_turnos ddlb_turnos
cb_insertar cb_insertar
cb_borrar cb_borrar
cb_grabar cb_grabar
r_1 r_1
st_linea st_linea
uo_linea uo_linea
dw_3 dw_3
p_1 p_1
st_5 st_5
st_seccion st_seccion
dw_2 dw_2
dw_1 dw_1
cb_importar cb_importar
p_flecha p_flecha
cb_1 cb_1
dw_4 dw_4
r_2 r_2
end type
global w_int_prodpartes_ot w_int_prodpartes_ot

type variables

end variables

forward prototypes
public subroutine f_consulta ()
public subroutine f_activar (boolean bool)
end prototypes

public subroutine f_consulta ();string operario,turno,linea
datetime fecha

fecha=datetime(date(em_fecha.text))

if isnull(fecha) or year(date(fecha))=1900 then
	return
end if

operario=uo_operario.em_codigo.text
if operario='' then 
	return
end if

linea = uo_linea.em_codigo.text
if linea = '' then 
	return
end if

choose case ddlb_turnos.text
	case 'Mañana'
		turno='1'
	case 'Tarde'
		turno='2'
	case 'Noche'
		turno='3'
end choose

dw_1.retrieve(codigo_empresa,operario,linea,fecha,turno)	

end subroutine

public subroutine f_activar (boolean bool);cb_borrar.enabled=bool
cb_grabar.enabled=bool
cb_insertar.enabled=bool
ddlb_turnos.enabled=bool
dw_1.enabled=bool
em_fecha.enabled=bool
uo_linea.enabled=bool
uo_operario.enabled=bool

dw_2.visible=not bool

dw_4.visible = not bool
end subroutine

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.cb_grabar.visible = false;
		This.cb_importar.visible = false;
end choose


istr_parametros.s_titulo_ventana="Entrada de Partes de Producción"
This.title=istr_parametros.s_titulo_ventana

dw_1.Settransobject(SQLCA)
dw_2.Settransobject(SQLCA)
dw_3.Settransobject(SQLCA)
dw_4.Settransobject(SQLCA)
dw_1.setrowfocusindicator(p_flecha)
//dw_1.setrowfocusindicator(hand!)
dw_2.setrowfocusindicator(hand!)
dw_1.ue_marca_linea=false
dw_2.ue_marca_linea=false
em_fecha.text = string(today(),"dd-mm-yy")
ddlb_turnos.text='Mañana'
f_activar_campo(uo_operario.em_campo)
end event

on w_int_prodpartes_ot.create
int iCurrent
call super::create
this.st_turno=create st_turno
this.pb_1=create pb_1
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.st_operario=create st_operario
this.uo_operario=create uo_operario
this.ddlb_turnos=create ddlb_turnos
this.cb_insertar=create cb_insertar
this.cb_borrar=create cb_borrar
this.cb_grabar=create cb_grabar
this.r_1=create r_1
this.st_linea=create st_linea
this.uo_linea=create uo_linea
this.dw_3=create dw_3
this.p_1=create p_1
this.st_5=create st_5
this.st_seccion=create st_seccion
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_importar=create cb_importar
this.p_flecha=create p_flecha
this.cb_1=create cb_1
this.dw_4=create dw_4
this.r_2=create r_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_turno
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_fecha
this.Control[iCurrent+4]=this.em_fecha
this.Control[iCurrent+5]=this.st_operario
this.Control[iCurrent+6]=this.uo_operario
this.Control[iCurrent+7]=this.ddlb_turnos
this.Control[iCurrent+8]=this.cb_insertar
this.Control[iCurrent+9]=this.cb_borrar
this.Control[iCurrent+10]=this.cb_grabar
this.Control[iCurrent+11]=this.r_1
this.Control[iCurrent+12]=this.st_linea
this.Control[iCurrent+13]=this.uo_linea
this.Control[iCurrent+14]=this.dw_3
this.Control[iCurrent+15]=this.p_1
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.st_seccion
this.Control[iCurrent+18]=this.dw_2
this.Control[iCurrent+19]=this.dw_1
this.Control[iCurrent+20]=this.cb_importar
this.Control[iCurrent+21]=this.p_flecha
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.dw_4
this.Control[iCurrent+24]=this.r_2
end on

on w_int_prodpartes_ot.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_turno)
destroy(this.pb_1)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.st_operario)
destroy(this.uo_operario)
destroy(this.ddlb_turnos)
destroy(this.cb_insertar)
destroy(this.cb_borrar)
destroy(this.cb_grabar)
destroy(this.r_1)
destroy(this.st_linea)
destroy(this.uo_linea)
destroy(this.dw_3)
destroy(this.p_1)
destroy(this.st_5)
destroy(this.st_seccion)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_importar)
destroy(this.p_flecha)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.r_2)
end on

event closequery;if dw_1.modifiedcount()<>0 or dw_1.deletedcount()<>0 then
	if messagebox("Atención","Hay lineas sin grabar. ¿Está seguro que desea salir?",information!,YesNo!,2)=2 then
		return 1
	end if
end if
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_prodpartes_ot
integer x = 1627
integer y = 244
integer taborder = 100
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_prodpartes_ot
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_prodpartes_ot
integer x = 37
integer y = 16
integer width = 3712
integer height = 88
integer textsize = -12
end type

type st_turno from statictext within w_int_prodpartes_ot
integer x = 1573
integer y = 168
integer width = 384
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Turno"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_int_prodpartes_ot
integer x = 4466
integer y = 188
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
alignment htextalign = right!
end type

type st_fecha from statictext within w_int_prodpartes_ot
integer x = 1961
integer y = 168
integer width = 306
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_prodpartes_ot
integer x = 1961
integer y = 248
integer width = 306
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;f_consulta()
end event

type st_operario from statictext within w_int_prodpartes_ot
integer x = 37
integer y = 168
integer width = 677
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Operario"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_operario from u_em_campo_2 within w_int_prodpartes_ot
event destroy ( )
integer x = 32
integer y = 248
integer width = 677
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_operario.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_operario.em_campo.text = f_nombre_almoperarios_abr(codigo_empresa,uo_operario.em_codigo.text)
IF Trim(uo_operario.em_campo.text)="" THEN 
 IF Trim(uo_operario.em_codigo.text) <> "" Then
	uo_operario.em_campo.SetFocus()
END IF
 uo_operario.em_campo.text  = ""
 uo_operario.em_codigo.text = ""
END IF

f_consulta()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de operarios"
ue_datawindow = "dw_ayuda_operarios"
ue_filtro     = ""

end event

type ddlb_turnos from dropdownlistbox within w_int_prodpartes_ot
integer x = 1573
integer y = 248
integer width = 384
integer height = 312
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Mañana","Tarde","Noche"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;f_consulta()
end event

type cb_insertar from u_boton within w_int_prodpartes_ot
integer x = 3328
integer y = 192
integer width = 361
integer height = 92
integer taborder = 70
boolean bringtotop = true
string text = "&Insertar"
end type

event clicked;string operario,turno,linea, v_seccion
datetime fecha
long donde,cont
int contador

fecha=datetime(date(em_fecha.text))

if isnull(fecha) or year(date(fecha))=1900 then
	return
end if

operario=uo_operario.em_codigo.text
if operario='' then 
	return
end if

linea = uo_linea.em_codigo.text
if linea = '' then 
	return
end if

choose case ddlb_turnos.text
	case 'Mañana'
		turno='1'
	case 'Tarde'
		turno='2'
	case 'Noche'
		turno='3'
end choose

donde=dw_1.insertrow(0)

contador=0
for cont=1 to dw_1.rowcount()
	if dw_1.object.contador[cont]>contador then
		contador=dw_1.object.contador[cont]
	end if
next
contador++

select codigo 
into :v_seccion
from prodsecciones
where empresa = :codigo_empresa
and descripcion_abr = :st_seccion.text;


dw_1.object.empresa[donde] = codigo_empresa
dw_1.object.operario[donde] = operario
dw_1.object.linea[donde] = linea
dw_1.object.seccion[donde] = v_seccion	
dw_1.object.prodpartes_ot_fecha[donde] = fecha
dw_1.object.turno[donde] = turno
dw_1.object.contador[donde] = contador
dw_1.object.ot_terminada[donde] = "N"
dw_1.object.art_terminado[donde] = "N"
dw_1.object.buenas[donde] = 0
dw_1.object.malas[donde] = 0


dw_1.setfocus()
dw_1.scrolltorow(donde)
dw_1.setcolumn("ot")
end event

type cb_borrar from u_boton within w_int_prodpartes_ot
integer x = 3694
integer y = 192
integer width = 361
integer height = 92
integer taborder = 80
boolean bringtotop = true
string text = "&Borrar"
end type

event clicked;dw_1.deleterow(dw_1.getrow())
end event

type cb_grabar from u_boton within w_int_prodpartes_ot
integer x = 4059
integer y = 192
integer width = 320
integer height = 92
integer taborder = 90
boolean bringtotop = true
string text = "&Grabar"
end type

event clicked;decimal segundos
integer i, j, ordenoperacion,  ordenoperacion2
time v_horainicio
time v_horafin
// Esto será para el calculo de velocidades
decimal{8}  velocidad_segs, coste_std, correccion_velocidad, coste_fabricacion, coste_compras
datetime hoy, antes
string articulo, ver, tipo_operacion , lineaprod, v_seccion, LOTE
dec ciclo, ancho, largo, longitud_horno = 29.4
string orientacion
long piezas_fila, piezas_hora_horno, piezas, piezas_hora
boolean correcto = true, fallo
decimal coste_fab, coste_mp, costePacking

connect using SQLCA;
dw_1.AcceptText()

for i = 1 to dw_1.Rowcount() 
	if isnull(time(dw_1.object.horainicio[i]) ) then	v_horainicio = time(00:00:00)	else	v_horainicio = time(dw_1.object.horainicio[i])	
	if isnull(time(dw_1.object.horafin[i])) then	v_horafin = time(00:00:00)	else	v_horafin = time(dw_1.object.horafin[i])
	
	if secondsafter (v_horainicio, v_horafin) >= 0 then
		segundos = secondsafter (v_horainicio, v_horafin)
	else 
		segundos = secondsafter (v_horainicio, 23:59:59) + secondsafter (00:00:00, v_horafin)
	end if
	
	dw_1.object.segundos[i] = segundos
next

hoy = datetime(today())
antes = datetime(RelativeDate ( today(), -365 ))

if dw_1.update() <> 1 then
	f_mensaje("Atención","Error al grabar. ")
	correcto = false
end if
	
// Podríamos grabar la velocidad en la tabla de velocidades y ahorrarnos ese cálculo al generar OT`s ?????
for j = 1 to dw_1.rowcount()
	articulo = dw_1.object.articulo[j]
	ver = dw_1.object.version[j]
	tipo_operacion = dw_1.object.operacion[j]
	ordenoperacion = dw_1.object.ordenoperacion[j]
	v_seccion = dw_1.object.seccion[j]
	piezas = dw_1.object.buenas[j]
	lote = dw_1.object.lote[j]
	lineaprod = dw_1.object.linea[j]
	

// Calculamos la velocidad de la sección en la que estamos pasando el parte.

	select sum(prodpartes_ot.buenas) / sum(prodpartes_ot.segundos) 
	into :velocidad_Segs
	from prodpartes_ot
	where prodpartes_ot.empresa = :codigo_empresa
	and prodpartes_ot.articulo = :articulo
	and prodpartes_ot.version = :ver
	and prodpartes_ot.ordenoperacion = :ordenoperacion 
	and prodpartes_ot.segundos <> 0
	and prodpartes_ot.segundos is not null
	and prodpartes_ot.ajuste <> 'S'
	and prodpartes_ot.seccion = :v_seccion
	and ( prodpartes_ot.seccion <> '8' or ( prodpartes_ot.seccion = '8' and  prodpartes_ot.linea = '19' ) );  // No cogemos partes de operaciones manuales excepto de CORTE MANUAL
//		and prodpartes_ot.seccion <> '8';  // No cogemos partes de la sección de operaciones manuales.
	
	piezas_hora = velocidad_segs * 3600
	
	select coste, correccion_velocidad
	into :coste_std, :correccion_velocidad
	from art_ver_tipooperacion
	where	empresa = :codigo_empresa
	and codigo = :tipo_operacion ;
	
	if piezas_hora = 0 or correccion_velocidad = 0 or isnull(piezas_hora) or isnull(correccion_velocidad) then 
		coste_fabricacion = 0
	else
		coste_fabricacion = ( coste_std / ( piezas_hora * correccion_velocidad ) )
	end if
	
	Select (comartpro.precio / articulos.cant_compras) coste_compras 
	into :coste_compras
	from articulos
	left outer join venmprima on articulos.empresa = venmprima.empresa  
						and articulos.codigo_compras = venmprima.codigo 
	left outer join comartpro on venmprima.empresa = comartpro.empresa  
						and venmprima.codigo = comartpro.mprima   
						and comartpro.proveedor = ( select top 1 C2.proveedor   
													from comartpro  C2   
													where C2.empresa = comartpro.empresa  
													and C2.mprima = comartpro.mprima   
													order by precio asc) 
													
	where articulos.empresa = :codigo_empresa
	and articulos.codigo = :articulo;
	
	
	costePacking = f_calculo_coste_packing (codigo_empresa, articulo )
	
	update art_ver_operaciones
	set coste_fab = :coste_fabricacion, coste_compras = :coste_compras, coste_packing = :costepacking
	where empresa = :codigo_empresa
	and articulo = :articulo
	and version = :ver
	and orden = :ordenoperacion ;
	if SQLCA.SQLCode <> 0 then
		f_mensaje("Atención","Hubo un error al cáclular el coste de fabricación. ")
		correcto = false
	end if

	/*LOTES*/	
	
	fallo = f_actualizar_coste_lote_planificacion(codigo_empresa,articulo,sqlca,lote,ver,tipo_operacion, lineaprod)
	
	if fallo = true then f_mensaje("Atención","Hubo un error al calcular los costes")
	
	
	
//		// Cálculo Coste con mermas		
//		if tipo_operacion = "9" and correcto then  // Encajar
//			correcto = f_calculo_coste_mermas (codigo_empresa, articulo, '1' )
//		end if
//		// Fin Cálculo Coste con mermas		
	
	f_mensaje_proceso ("Calculando ... ", j , dw_1.rowcount())
next
	
if correcto then
	if dw_1.update() <> 1 then
		f_mensaje("Atención","Hubo un error al grabar")
		rollback using SQLCA;
	else
		commit using SQLCA;
	end if	
end if
end event

type r_1 from rectangle within w_int_prodpartes_ot
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 16711680
integer x = 3314
integer y = 180
integer width = 1083
integer height = 112
end type

type st_linea from statictext within w_int_prodpartes_ot
integer x = 718
integer y = 168
integer width = 489
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Línea"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_linea from u_em_campo_2 within w_int_prodpartes_ot
event destroy ( )
integer x = 718
integer y = 248
integer width = 375
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_linea.destroy
call u_em_campo_2::destroy
end on

event modificado;string v_seccion

uo_linea.em_campo.text=f_nombre_linea_abr(codigo_empresa,uo_linea.em_codigo.text)
IF Trim(uo_linea.em_campo.text)="" THEN 
 IF Trim(uo_linea.em_codigo.text) <> "" Then
	uo_linea.em_campo.SetFocus()
END IF
 uo_linea.em_campo.text  = ""
 uo_linea.em_codigo.text = ""
END IF

v_seccion = ""
select prodsecciones.descripcion_abr
into :v_seccion
from prodsecciones, prodlineas
where prodsecciones.empresa = :codigo_empresa
and prodlineas.empresa = :codigo_empresa
and prodsecciones.codigo = prodlineas.seccion
and prodlineas.codigo = :uo_linea.em_codigo.text;

st_seccion.text = v_seccion

f_consulta()
end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda Selección de Líneas"
ue_datawindow = "dw_ayuda_prodlineas"
ue_filtro     = "activo = 'S'"

end event

type dw_3 from datawindow within w_int_prodpartes_ot
boolean visible = false
integer x = 32
integer y = 1392
integer width = 2807
integer height = 428
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_int_prodpartesobservaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string turno,linea
datetime fecha
long donde,cont

choose case dwo.name
	case "t_grabar"
		if dw_3.update()<>1 then
			f_mensaje("Atención","Hubo un error al grabar")
		else
			f_mensaje("Ok","Información grabada correctamente")
		end if
		cb_borrar.enabled=false
		cb_grabar.enabled=false
		cb_insertar.enabled=false
		ddlb_turnos.enabled=false
		dw_1.enabled=false
		em_fecha.enabled=false
		uo_linea.enabled=false
		uo_operario.enabled=false
		dw_3.visible=true


	case "t_borrar"
		dw_3.deleterow(dw_2.getrow())
	case "t_insertar"
		
		fecha=datetime(date(em_fecha.text))
		
		if isnull(fecha) or year(date(fecha))=1900 then
			return
		end if
		
		linea = uo_linea.em_codigo.text
		if linea = '' then 
			return
		end if
		
		choose case ddlb_turnos.text
			case 'Mañana'
				turno='M'
			case 'Tarde'
				turno='T'
			case 'Noche'
				turno='N'
		end choose
		
		donde=dw_3.insertrow(0)
		
		dw_3.object.empresa[donde]=codigo_empresa
		dw_3.object.linea[donde]=linea
		dw_3.object.turno[donde]=turno
		dw_3.object.fecha[donde]=fecha
		
		dw_3.setfocus()
		dw_3.scrolltorow(donde)
		dw_3.setcolumn("observaciones")		
	case "t_salir"
		if dw_3.modifiedcount()<>0 or dw_3.deletedcount()<>0 then
			if messagebox("Atención","Hay lineas sin grabar. ¿Está seguro que desea salir?",information!,YesNo!,2)=1 then
				cb_borrar.enabled=true
				cb_grabar.enabled=true
				cb_insertar.enabled=true
				ddlb_turnos.enabled=true
				dw_1.enabled=true
				em_fecha.enabled=true
				uo_linea.enabled=true
				uo_operario.enabled=true
				dw_3.visible=false
			end if
		else
				cb_borrar.enabled=true
				cb_grabar.enabled=true
				cb_insertar.enabled=true
				ddlb_turnos.enabled=true
				dw_1.enabled=true
				em_fecha.enabled=true
				uo_linea.enabled=true
				uo_operario.enabled=true
				dw_3.visible=false
		end if		
end choose
end event

type p_1 from picture within w_int_prodpartes_ot
integer x = 1097
integer y = 252
integer width = 91
integer height = 80
boolean bringtotop = true
string picturename = "c:\bmp\carpeta.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_int_prodpartes_ot"
lstr_param.s_argumentos[2]=uo_linea.em_codigo.text
OpenWithParm(w_mant_secciones,lstr_param)  

end event

type st_5 from statictext within w_int_prodpartes_ot
integer x = 1211
integer y = 168
integer width = 357
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
boolean enabled = false
string text = "Sección"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_seccion from statictext within w_int_prodpartes_ot
integer x = 1211
integer y = 248
integer width = 352
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_2 from u_datawindow_consultas within w_int_prodpartes_ot
boolean visible = false
integer x = 837
integer y = 632
integer width = 1125
integer height = 556
integer taborder = 30
string dataobject = "dw_int_prodpartesdefectos"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;string operario,turno,linea
datetime fecha
long donde,contador,cont

choose case dwo.name
	case "t_grabar"
		if dw_2.update()<>1 then
			f_mensaje("Atención","Hubo un error al grabar")
		else
			f_mensaje("Ok","Información grabada correctamente")
		end if
		f_activar(false)
	case "t_borrar"
		dw_2.deleterow(dw_2.getrow())
	case "t_insertar"
		
		fecha=datetime(date(em_fecha.text))
		
		if isnull(fecha) or year(date(fecha))=1900 then
			return
		end if
		
		operario=uo_operario.em_codigo.text
		if operario='' then 
			return
		end if
		
		linea = uo_linea.em_codigo.text
		if linea ='' then 
			return
		end if
		
		choose case ddlb_turnos.text
			case 'Mañana'
				turno='M'
			case 'Tarde'
				turno='T'
			case 'Noche'
				turno='N'
		end choose
		
		donde=dw_2.insertrow(0)
		
		contador=dw_1.object.contador[dw_1.getrow()]
		
		dw_2.object.empresa[donde]=codigo_empresa
		dw_2.object.linea[donde] = linea
		dw_2.object.operario[donde]=operario
		dw_2.object.turno[donde]=turno
		dw_2.object.fecha[donde]=fecha
		dw_2.object.contador[donde]=contador
		
		dw_2.setfocus()
		dw_2.scrolltorow(donde)
		dw_2.setcolumn("tipodefecto")		
	case "t_salir"
		if dw_2.modifiedcount()<>0 or dw_2.deletedcount()<>0 then
			if messagebox("Atención","Hay lineas sin grabar. ¿Está seguro que desea salir?",information!,YesNo!,2)=1 then
				f_activar(true)
			end if
		else
			f_activar(true)
		end if		
end choose
end event

event key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipodefecto"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE DEFECTOS"
 		bus_datawindow = "dw_ayuda_prodtipodefectos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

event rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipodefecto"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE DEFECTOS"
 		bus_datawindow = "dw_ayuda_prodtipodefectos"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 

end event

type dw_1 from u_datawindow_consultas_2_criterios within w_int_prodpartes_ot
integer x = 5
integer y = 352
integer width = 4626
integer height = 3020
integer taborder = 0
string dataobject = "dw_int_prodpartes_ot"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event key;valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "articulo"
      bus_titulo     = "VENTANA SELECCION DE ARTICULOS"
 		bus_datawindow = "dw_ayuda_articulos_2_criterios"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
end event

event rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "articulo"
      bus_titulo     = "VENTANA SELECCION DE ARTICULOS"
 		bus_datawindow = "dw_ayuda_articulos_2_criterios"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event doubleclicked;if row=0 then return
if rowcount()=0 then return

string operario,turno,linea
datetime fecha
int contador

fecha=datetime(date(em_fecha.text))

if isnull(fecha) or year(date(fecha))=1900 then
	return
end if

operario=uo_operario.em_codigo.text
if operario='' then 
	return
end if

linea = uo_linea.em_codigo.text
if linea = '' then 
	return
end if

choose case ddlb_turnos.text
	case 'Mañana'
		turno='M'
	case 'Tarde'
		turno='T'
	case 'Noche'
		turno='N'
end choose

contador=dw_1.object.contador[row]

dw_1.setrow(row)

dw_2.retrieve(codigo_empresa,operario,linea,fecha,turno,contador)	


f_activar(false)
end event

event itemchanged;integer v_anyo, v_pedido, v_linped, v_ordenoperacion,li_calibre
dec v_cantidad_orig, v_ot, v_factor
string v_formato, v_articulo, v_version, v_tipooperacion, v_seccion, v_operacion, v_ajuste, v_art_encajado,ls_lote, v_requiere_stock, v_lote

dw_1.accepttext()

CHOOSE CASE dwo.name
	CASE "ot"
		v_ot = dw_1.object.ot[row]
		
		select planificacion.anyo, planificacion.pedido, planificacion.linped, planificacion.ordenoperacion, 
				planificacion.tipo_operacion, planificacion.cantidad, planificacion.formato, planificacion.cod_Articulo, 
				planificacion.version, art_ver_tipooperacion.descripcion_Abr, ajuste, factor, art_encajado,
				lote, calibre 
		into :v_anyo, :v_pedido, :v_linped, :v_ordenoperacion, :v_tipooperacion, :v_cantidad_orig, :v_formato, 
			   :v_articulo, :v_version, :v_operacion, :v_ajuste, :v_factor, :v_art_encajado,
				:ls_lote, :li_calibre 
		from planificacion, art_ver_tipooperacion 
		where planificacion.empresa = :codigo_empresa
		and art_ver_tipooperacion.empresa = :codigo_empresa
		and planificacion.tipo_operacion = art_ver_tipooperacion.codigo
		and planificacion.ot = :v_ot;

		dw_1.object.articulo[row] = v_articulo 
		dw_1.object.version[row] = v_version
		dw_1.object.operacion[row] = v_tipooperacion
		dw_1.object.ordenoperacion[row] = v_ordenoperacion
		dw_1.object.anyo[row] = v_anyo
		dw_1.object.pedido[row] = v_pedido
		dw_1.object.linped[row] = v_linped
		dw_1.object.cantidad_orig[row] = v_cantidad_orig
		dw_1.object.formato[row] = v_formato
		dw_1.object.ajuste[row] = v_ajuste
		dw_1.object.factor[row] = v_factor
		dw_1.object.art_encajado[row] = v_art_encajado
		dw_1.object.lote[row] = ls_lote
		dw_1.object.calibre[row] = li_calibre
	
//		dw_1.object.art_ver_tipooperacion_descripcion_abr[row] = v_operacion
	CASE "articulo"
		v_articulo = dw_1.object.articulo[row]
		
		select formato
		into :v_formato
		from articulos
		where empresa = :codigo_empresa
		and codigo = :v_articulo;
		
		dw_1.object.formato[row] = v_formato
		
	CASE "malas"
		
		v_articulo = dw_1.object.articulo[row]
		v_version = dw_1.object.version[row]
		
		select requiere_stock
		into :v_requiere_stock
		from art_versiones
		where articulo = :v_articulo
		and version = :v_version
		and empresa = :codigo_empresa;
		
		if v_requiere_stock = 'S' then
			
			v_operacion = dw_1.object.operacion[row]
			
			v_lote = dw_1.object.lote[row]
			
			dw_4.reset()
			
			dw_4.retrieve(codigo_empresa,v_articulo,v_lote,v_version,v_operacion)
			
			dw_4.visible = true
			
		end if
		
	
END CHOOSE

end event

event clicked;call super::clicked;string v_articulo, v_version, v_requiere_stock, v_operacion, v_lote


if dwo.name = 'b_lotes' then
	
	dw_1.setrow(row)
	
	v_articulo = dw_1.object.articulo[row]
	v_version = dw_1.object.version[row]
		
	select requiere_stock
	into :v_requiere_stock
	from art_versiones
	where articulo = :v_articulo
	and version = :v_version
	and empresa = :codigo_empresa;
				
	v_operacion = dw_1.object.operacion[row]
			
	v_lote = dw_1.object.lote[row]
			
	dw_4.reset()
			
	dw_4.retrieve(codigo_empresa,v_articulo,v_lote,v_version,v_operacion)
			
	dw_4.visible = true

end if
end event

type cb_importar from commandbutton within w_int_prodpartes_ot
boolean visible = false
integer x = 2889
integer y = 1240
integer width = 544
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar Partes"
end type

event clicked;string sel, v_operario, v_tipoparte, v_turno, v_articulo, v_comentarios, v_grupparte, v_terminado, v_linea
string v_seccion, v_ot_terminada, v_art_terminado, v_version, v_operacion, v_formato
datetime v_fecha
int V_contador, v_anyo, v_pedido, v_linped
dec v_buenas, v_malas, v_ot
datastore partes, operaciones
long total_partes, total_operaciones, i, j
boolean bien = true


IF MessageBox("PELIGRO", nombre_usuario+", Dale a <CANCELAR> o la liaremos",Exclamation!, OKCancel!, 2) = 2 THEN
	RETURN
END IF


sel = " select operario, tipoparte, fecha, turno, contador, articulo, buenas, malas, "+&
		" comentarios, grupoparte, terminado "+&
		" from prodpartes "+&
		" where empresa = "+codigo_empresa+&
		" and articulo <> '' "+&
		" and articulo is not null; "
		
//partes = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, partes)

total_partes = partes.RowCount()
v_contador = 1


for i = 1 to total_partes
	choose case partes.object.tipoparte[i]
		case "1"
			v_linea = "7"
			v_seccion = "3"
			v_operacion = "3"
		case "4" 
			v_linea = "5"
			v_seccion = "2"
			v_operacion = "1"
		case "5"	
			v_linea = "6"
			v_seccion = "2"
			v_operacion = "1"
		case "6"
			v_linea = "1"
			v_seccion = "1"
			v_operacion = "2"
		case "7"
			v_linea = "2"
			v_seccion = "1"
			v_operacion = "2"
		case "8"
			v_linea = "11"
			v_seccion = "4"
			v_operacion = "5"
	end choose
	
	choose case partes.object.turno[i]
		case "M"
			v_turno = "1"
		case "T" 
			v_turno = "2"
		case "N"	
			v_turno = "3"
	end choose
	
	
	v_operario = partes.object.operario[i]
	v_fecha = partes.object.fecha[i]
	v_ot = 1
	v_ot_terminada = "S"
	v_comentarios = partes.object.comentarios[i]
	v_articulo = partes.object.articulo[i]
	v_version = "1"
	v_anyo = 1
	v_pedido = 1
	v_linped = 1
	v_buenas = 	partes.object.buenas[i]
	v_malas = 	partes.object.malas[i]
	v_art_terminado = partes.object.terminado[i]	


	v_formato = ""
	select formato 
	into :v_formato
	from articulos 
	where codigo = :v_articulo;
	
	

	insert into prodpartes_ot
	(empresa, operario, linea, fecha, turno, contador, seccion, ot, ot_terminada, cometarios, art_terminado,
	articulo, version, operacion, anyo, pedido, linped, buenas, malas, formato)
	values 
	(:codigo_empresa, :v_operario, :v_linea, :v_fecha, :v_turno, :v_contador, :v_seccion, :v_ot, :v_ot_terminada,
	:v_comentarios, :v_art_terminado, :v_articulo, :v_version, :v_operacion, :v_anyo, :v_pedido, :v_linped,
	:v_buenas, :v_malas, :v_formato);

	v_contador = v_contador +1
	if SQLCA.SQLCode = -1 then 
		bien = false
	end if

	f_mensaje_proceso("Importando partes: ",i,partes.Rowcount())

next
if bien then
	commit;
else 
	rollback;
	messagebox ("ERROR" , "Se ha producido un error, no se ha hecho la importacion")
end if
	
destroy partes
destroy operaciones
end event

type p_flecha from picture within w_int_prodpartes_ot
integer x = 1783
integer y = 1128
integer width = 37
integer height = 32
boolean originalsize = true
string picturename = "c:\bmp\flecha_derecha.bmp"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_int_prodpartes_ot
boolean visible = false
integer x = 2437
integer y = 276
integer width = 1061
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calculo Coste Mermas Global"
end type

event clicked;string tipo_operacion, sel, articulo, articulo2, version2
datastore datos, articulos
long k, m
integer ordenoperacion2
dec  buenas2, malas2, piezas_totales_encajado, coste_fab, coste_mp, piezas_extra , coste_fab_mermas, coste_mp_mermas
boolean correcto = true


// Cálculo Coste con mermas	
sel =  	" select codigo "+&
			" from articulos "+&
			" where empresa = '"+codigo_empresa+"' "+&
			" and uso = '3'"
			
f_Cargar_cursor_nuevo (sel, articulos)
for m = 1 to articulos.rowcount()
	articulo = articulos.object.codigo[m]
	if correcto = true then
		correcto = f_calculo_coste_mermas (codigo_empresa, articulo, '1' )
	end if
next
destroy articulos
// Fin Cálculo Coste con mermas		

if correcto then
	commit using SQLCA;
else
	rollback using SQLCA;
end if
end event

type dw_4 from u_datawindow_consultas within w_int_prodpartes_ot
boolean visible = false
integer x = 1632
integer y = 728
integer width = 2574
integer height = 756
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string dataobject = "dw_int_prodpartes_lotes"
boolean controlmenu = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;string empresa, articulo,lote,ver,operacion, articulo_stock,lote_stock
long cantidad_pzs, cantidad_pzs_totales, cantidad_pzs_comprobacion, fila,  total_filas, fila_encontrada, fila_siguiente
decimal porcentaje_pzs
decimal {8} coste_total, coste_fabricacion_teorico, coste_fabricacion_mermas, coste_mp, coste_mp_mermas


choose case dwo.name
	case "t_grabar"
		
		coste_total = 0
		dw_4.accepttext()
		
		if dw_4.rowcount() > 0 then
			
			fila = 1
			total_filas = dw_4.rowcount()
			
			do while fila < total_filas
				
				lote_stock = dw_4.object.lote_stock[fila]
				
				/*
				
				string evaluate
				
				evaluate =  dw_4.Describe("Evaluate('Sum(if (lote_stock = '"+lote_stock+"',cantidad_pzs,0) for all )' )")
				
				messagebox("",evaluate)
					
				//dw_4.object.cantidad_pzs[fila] = dw_4.Describe("Evaluate('Sum(if (lote_stock = ' "+lote_stock+" ',cantidad_pzs,0) for all )' )")
				
				*/
				
				fila_encontrada = 0
				
				fila_siguiente = fila + 1
			
				fila_encontrada = dw_4.find ("lote_stock = '"+lote_stock+"' ", fila_siguiente, total_filas )
				
				do while fila_encontrada <> 0 and total_filas > 1 and fila_encontrada <> fila
					
					dw_4.object.cantidad_pzs[fila] = dw_4.object.cantidad_pzs[fila] + dw_4.object.cantidad_pzs[fila_encontrada]
					
					dw_4.deleterow(fila_encontrada)
					
					total_filas = dw_4.rowcount()
					
					fila_encontrada = 0
				
					fila_encontrada = dw_4.find ("lote_stock = '"+lote_stock+"' ", fila_siguiente, total_filas )
					
				loop
				fila = fila + 1
				total_filas = dw_4.rowcount()
				
			loop					
		end if
		
		/*
		
		for i = 1 to dw_4.rowcount()
		
			lote_stock = dw_4.object.lote_stock[i]
	
			empresa = dw_1.object.empresa[dw_1.getrow()]
			articulo = dw_1.object.articulo[dw_1.getrow()]
			ver = dw_1.object.version[dw_1.getrow()]
			articulo_stock = dw_4.object.articulo_stock[i]
	
			select operacion
			into :operacion
			from art_ver_operaciones
			where empresa = :codigo_empresa
			and articulo = :articulo_stock
			and version = :ver;
			
			select isnull(coste_fabricacion_teorico,0),isnull(coste_fabricacion_mermas,0),isnull(coste_mp,0),isnull(coste_mp_mermas,0)
			into :coste_fabricacion_teorico, :coste_fabricacion_mermas, :coste_mp, :coste_mp_mermas
			from articulos_coste_lote
			where empresa = :codigo_empresa
			and articulo = :articulo_stock
			and lote = :lote_stock
			and operacion = :operacion;
			
			cantidad_pzs = dw_4.object.cantidad_pzs[i]
			
			porcentaje_pzs = (100 * cantidad_pzs) / cantidad_pzs_totales
			
			coste_total =  ((coste_fabricacion_teorico + coste_fabricacion_mermas + coste_mp + coste_mp_mermas)  * (porcentaje_pzs/100)  ) 
			
			coste_fabricacion_teorico=  ((coste_fabricacion_teorico )  * (porcentaje_pzs/100)  ) 
			
			coste_fabricacion_mermas=  ((coste_fabricacion_mermas )  * (porcentaje_pzs/100)  ) 
			
			coste_mp =  ((coste_mp )  * (porcentaje_pzs/100)  ) 
			
			coste_mp_mermas =  ((coste_mp_mermas )  * (porcentaje_pzs/100)  ) 
								
			dw_4.object.coste_total[i] = coste_total
			
			dw_4.object.coste_fabricacion_teorico[i] = coste_fabricacion_teorico
			
			dw_4.object.coste_fabricacion_mermas[i] = coste_fabricacion_mermas
			
			dw_4.object.coste_mp[i] = coste_mp
			
			dw_4.object.coste_mp_mermas[i] = coste_mp_mermas
				
		next
		
		*/
		
		if dw_4.update()<>1 then
			f_mensaje("Atención","Hubo un error al grabar")
		else
			f_mensaje("Ok","Información grabada correctamente")
		end if
		dw_4.visible = false
		
	case "t_borrar"
		dw_4.deleterow(dw_4.getrow())
	case "t_insertar"
		
		empresa = dw_1.object.empresa[dw_1.getrow()]
		articulo = dw_1.object.articulo[dw_1.getrow()]
		lote = dw_1.object.lote[dw_1.getrow()]
		ver = dw_1.object.version[dw_1.getrow()]
		operacion = dw_1.object.operacion[dw_1.getrow()]

		
		dw_4.accepttext()
												
		fila = dw_4.insertrow(0)			
				
		dw_4.object.empresa[fila] = empresa
		dw_4.object.articulo[fila] = articulo
		dw_4.object.lote[fila] = lote
		dw_4.object.version[fila] = ver
		dw_4.object.operacion[fila] = operacion
		
					
		dw_4.setfocus()
		dw_4.scrolltorow(fila)
		dw_4.setrow(fila)
		dw_4.setcolumn("articulo_stock")
					

	case "t_salir"
		if dw_4.modifiedcount()<>0 or dw_4.deletedcount()<>0 then
			if messagebox("Atención","Hay lineas sin grabar. ¿Está seguro que desea salir?",information!,YesNo!,2)=1 then
				dw_4.visible = false
			end if
		else
			dw_4.visible = false
		end if	
		
	case else
		
		dw_4.setrow(row)
		
end choose
end event

event rbuttondown; /*string articulo_stock, articulo
 
 
 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
  
articulo = dw_1.object.articulo[dw_1.getrow()]

select articulo_ant
into :articulo_stock
from art_escandallo
where empresa = :codigo_empresa
and articulo = :articulo;

CHOOSE CASE bus_campo
	CASE "lote_stock"
      	bus_titulo     = "VENTANA SELECCION DE LOTES "
		 bus_datawindow = "dw_ayuda_prodlotes_stock"
		 bus_filtro = "articulo = '"+articulo_stock+"'  "
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 
 */
 
 
 

end event

event key; string articulo_stock, articulo
 
 
IF KeyDown(KeyEnter!) then
 
	 valor_empresa = TRUE	
	 bus_filtro=""
	 bus_campo = This.GetColumnName()
	 
	articulo = dw_1.object.articulo[dw_1.getrow()]
	
	select articulo_ant
	into :articulo_stock
	from art_escandallo
	where empresa = :codigo_empresa
	and articulo = :articulo;
	
	CHOOSE CASE bus_campo
		CASE "lote_stock"
				bus_titulo     = "VENTANA SELECCION DE LOTES "
			 bus_datawindow = "dw_ayuda_prodlotes_stock"
			 bus_filtro = "articulo = '"+articulo_stock+"'  "
		CASE ELSE
			SetNull(bus_campo)
	 END CHOOSE
	 CALL Super::rbuttondown
	 
end if
 
end event

event itemchanged;call super::itemchanged;string descripcion


if dwo.name = 'articulo_stock' then
	
	select descripcion
	into :descripcion
	from articulos
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_4.object.articulos_descripcion[row] = descripcion
	
	
end if
end event

type r_2 from rectangle within w_int_prodpartes_ot
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 16711680
integer x = 4453
integer y = 180
integer width = 137
integer height = 112
end type

