$PBExportHeader$w_planificacion_tencer_wide_copy.srw
forward
global type w_planificacion_tencer_wide_copy from w_int_con_empresa
end type
type r_1 from rectangle within w_planificacion_tencer_wide_copy
end type
type r_5 from rectangle within w_planificacion_tencer_wide_copy
end type
type dw_listado_planificacion from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_listado_ficha from datawindow within w_planificacion_tencer_wide_copy
end type
type st_titulo from statictext within w_planificacion_tencer_wide_copy
end type
type dw_necesidades_cajas from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_necesidades_granillas from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_ficha_operacion from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_listado_ficha2 from datawindow within w_planificacion_tencer_wide_copy
end type
type st_mensajes from statictext within w_planificacion_tencer_wide_copy
end type
type p_imagen from picture within w_planificacion_tencer_wide_copy
end type
type dw_estructura_planificada from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_2 from datawindow within w_planificacion_tencer_wide_copy
end type
type st_piezas from statictext within w_planificacion_tencer_wide_copy
end type
type st_m2 from statictext within w_planificacion_tencer_wide_copy
end type
type st_1 from statictext within w_planificacion_tencer_wide_copy
end type
type st_2 from statictext within w_planificacion_tencer_wide_copy
end type
type dw_necesidad_esmalte_ink from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_aplicaciones from datawindow within w_planificacion_tencer_wide_copy
end type
type cb_comprobar_tif from commandbutton within w_planificacion_tencer_wide_copy
end type
type dw_informe_archivos from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_imagen from u_dw_imagen within w_planificacion_tencer_wide_copy
end type
type dw_imagenes_extra from datawindow within w_planificacion_tencer_wide_copy
end type
type tv_1 from treeview within w_planificacion_tencer_wide_copy
end type
type dw_documento_almacen1 from datawindow within w_planificacion_tencer_wide_copy
end type
type uo_1 from u_em_campo_2 within w_planificacion_tencer_wide_copy
end type
type cb_2 from commandbutton within w_planificacion_tencer_wide_copy
end type
type cb_1 from commandbutton within w_planificacion_tencer_wide_copy
end type
type sle_1 from singlelineedit within w_planificacion_tencer_wide_copy
end type
type st_mensajes_envio from statictext within w_planificacion_tencer_wide_copy
end type
type sle_articulo from singlelineedit within w_planificacion_tencer_wide_copy
end type
type st_articulo from statictext within w_planificacion_tencer_wide_copy
end type
type dw_wow from datawindow within w_planificacion_tencer_wide_copy
end type
type dw_1 from u_datawindow within w_planificacion_tencer_wide_copy
end type
type ddlb_familias from dropdownlistbox within w_planificacion_tencer_wide_copy
end type
type cbx_ver_imagen from checkbox within w_planificacion_tencer_wide_copy
end type
type dw_totales from datawindow within w_planificacion_tencer_wide_copy
end type
type cbx_estructura from checkbox within w_planificacion_tencer_wide_copy
end type
type cbx_aplicaciones from checkbox within w_planificacion_tencer_wide_copy
end type
type cbx_arbol from checkbox within w_planificacion_tencer_wide_copy
end type
type cbx_promo from checkbox within w_planificacion_tencer_wide_copy
end type
type ddlb_filtros from dropdownlistbox within w_planificacion_tencer_wide_copy
end type
end forward

global type w_planificacion_tencer_wide_copy from w_int_con_empresa
integer width = 8745
integer height = 4032
string menuname = "menu_planificacion_tencer_wide"
r_1 r_1
r_5 r_5
dw_listado_planificacion dw_listado_planificacion
dw_listado_ficha dw_listado_ficha
st_titulo st_titulo
dw_necesidades_cajas dw_necesidades_cajas
dw_necesidades_granillas dw_necesidades_granillas
dw_ficha_operacion dw_ficha_operacion
dw_listado_ficha2 dw_listado_ficha2
st_mensajes st_mensajes
p_imagen p_imagen
dw_estructura_planificada dw_estructura_planificada
dw_2 dw_2
st_piezas st_piezas
st_m2 st_m2
st_1 st_1
st_2 st_2
dw_necesidad_esmalte_ink dw_necesidad_esmalte_ink
dw_aplicaciones dw_aplicaciones
cb_comprobar_tif cb_comprobar_tif
dw_informe_archivos dw_informe_archivos
dw_imagen dw_imagen
dw_imagenes_extra dw_imagenes_extra
tv_1 tv_1
dw_documento_almacen1 dw_documento_almacen1
uo_1 uo_1
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
st_mensajes_envio st_mensajes_envio
sle_articulo sle_articulo
st_articulo st_articulo
dw_wow dw_wow
dw_1 dw_1
ddlb_familias ddlb_familias
cbx_ver_imagen cbx_ver_imagen
dw_totales dw_totales
cbx_estructura cbx_estructura
cbx_aplicaciones cbx_aplicaciones
cbx_arbol cbx_arbol
cbx_promo cbx_promo
ddlb_filtros ddlb_filtros
end type
global w_planificacion_tencer_wide_copy w_planificacion_tencer_wide_copy

forward prototypes
public function integer f_planificar_wow ()
public subroutine f_ocultar_controles ()
public subroutine f_mostrar_controles ()
public subroutine f_filtrar_wow ()
end prototypes

public function integer f_planificar_wow ();// Devuelve 0 si todo ha ido bien

date v_f_entrega
boolean bien = True
dec i,j, total_lineaspedido, total_operaciones, ordent, v_cantidad, v_ordenoperacion
long v_pedido, v_linped, v_anyo, maximo_orden, v_factor
string v_operacion, tipooperacion, articulo, v_base, v_formato, v_version = "1", v_lineaprod = "1", v_reajuste = "N"
string v_descripcion_formato, sel
datawindow DW
str_escandallo vector_escandallo[300]
integer  k, indice , m
string v_g2, v_uso
decimal factor_Acumulado = 1
long cantidad_pedido
time hora_inicio
long segundos, minutos, total_lineas
integer nivel

nivel = 0

hora_inicio = now()
minutos = 0

DW = dw_wow
w_planificacion_tencer_wide.st_mensajes.visible = true

if MessageBox("Atención", "¿Desea generar nuevas OT´s", Exclamation!, YesNo!, 2) = 2 then
	return 1
else
	
	for i = 1 to dw_wow.Rowcount() 		
		if dw_wow.object.sugerido2[i] > 0 and not isnull (dw_wow.object.sugerido2[i]) then
			v_cantidad = dw_wow.object.sugerido2[i]
		else
			v_cantidad = dw_wow.object.sugerido[i]
		end if
		
		if dw_wow.object.marcado[i] = 'S' and v_cantidad > 0 then   //and  ( ( dw_wow.object.sugerido[i] > 0 and not isnull (dw_wow.object.sugerido[i] ) ) or  ( dw_wow.object.sugerido2[i] > 0 and not isnull (dw_wow.object.sugerido2[i] ) ) ) 
			w_planificacion_tencer_wide.st_mensajes.text = " Generando pedido "+string(i)+" de "+ string (dw_wow.object.total_marcados[i])+".  Quedan "+string(minutos)+ " minutos."
			articulo = dw_wow.object.articulos_codigo[i]
		
			v_pedido = 0
			v_linped = f_numero_linea_pedido_interno()
			v_anyo = year(today())
				
			v_operacion = '';
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// Recorremos recursivamente el árbol del artículo y llamamos a la función generar OT´s para cada nodo
			
			cantidad_pedido = v_cantidad 
			indice = 1
			for m = 1 to 300
				setnull(vector_Escandallo[m].articulo)
				setnull(vector_Escandallo[m].version)
				setnull(vector_Escandallo[m].factor)
			next
			if articulo <> '' and not isnull(articulo) then
				v_uso = ""
				SELECT uso INTO :v_uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo;
				if v_uso = '1' then
					f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_Acumulado, nivel, true)		
				else
					f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_Acumulado, nivel, false)		
				end if 
				for k=1 to indice
					select g2
					into :v_g2
					from art_codestadistico
					where codigo = :vector_Escandallo[k].articulo
					and empresa = :codigo_empresa;
					// Debe permitir que se programen las bases si hay pedido.
					//if (v_g2 <> "B" and v_g2 <> "Z" and v_g2 <> "N") or isnull(v_g2) or (articulo_linea =  vector_Escandallo[k].articulo) then //Error. El codigo estadistico no es significativo para saber si es base. Controlado en f_escandallo_factores_con_sin_base y usar funcion ftc_articulo_base()
						if vector_Escandallo[k].factor <> 0 and not isnull(vector_Escandallo[k].factor) then
							v_cantidad = cantidad_pedido / vector_Escandallo[k].factor
						else
							v_cantidad = cantidad_pedido
						end if
						f_generar_ots(vector_Escandallo[k].articulo, v_version, v_operacion, v_pedido, v_linped, &
										  v_anyo, v_cantidad, v_f_entrega, v_reajuste, articulo, vector_escandallo[k].factor, vector_Escandallo[k].nivel ,0,0) 
						
					//end if
				next
			end if
			commit using SQLCA;
			// fin del recorrido del árbol
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		//	f_mensaje_proceso("Generando OT's :",i ,  dw_wow.object.total_marcados[i])		
			segundos = secondsafter ( hora_inicio, now())
			minutos =  ( (segundos / i) * (total_lineas - i) ) / 60
	//		w_planificacion_tencer_wide.st_mensajes.text = w_planificacion_tencer_wide.st_mensajes.text + " Quedan "+string(minutos)+ " minutos."
		end if		
	next

//	destroy operaciones
	
//	 w_planificacion_tencer_wide.dw_1.Retrieve(codigo_empresa,"1")
end if

w_planificacion_tencer_wide.st_mensajes.visible = false


return 0;
end function

public subroutine f_ocultar_controles ();dw_imagen.visible = false
p_imagen.visible = false
tv_1.visible = false
dw_aplicaciones.visible = false
dw_estructura_planificada.visible = false
cb_comprobar_tif.visible = false
//uo_1.visible = false
r_1.visible = false

cbx_ver_imagen.visible = false
cbx_estructura.visible = false
cbx_aplicaciones.visible = false
cbx_arbol.visible = false


ddlb_filtros.visible = true
cbx_promo.visible = true


st_articulo.visible = true
sle_articulo.visible = true
end subroutine

public subroutine f_mostrar_controles ();ddlb_filtros.visible = false
cbx_promo.visible = false
cb_comprobar_tif.visible = true
cbx_ver_imagen.visible = true
cbx_estructura.visible = true
cbx_aplicaciones.visible = true
cbx_arbol.visible = true
//uo_1.visible = true
r_1.visible = true

if cbx_ver_imagen.checked then
	dw_imagen.visible = true
	p_imagen.visible = true
end if

if cbx_estructura.checked then
	dw_estructura_planificada.visible = true
end if

if cbx_aplicaciones.checked then
	dw_aplicaciones.visible = true
end if

if cbx_arbol.checked then
	tv_1.visible = true
end if

st_articulo.visible = false
sle_articulo.visible = false
end subroutine

public subroutine f_filtrar_wow ();string filtro
	
if cbx_promo.checked then
	filtro = "articulos_promocion = 'S'"
else
	filtro = "articulos_promocion = 'N'"
end if
	
CHOOSE CASE ddlb_filtros.text
	CASE  "Todos"
		//filtro = ""
	CASE  "Rotura Stock"
//		filtro = filtro + " and ped_menos_stock + planificado_bis < 0"
		filtro = filtro + " and ped_menos_stock < 0"

	CASE  "Con Stock Suficiente"
		filtro = filtro + " and stock >= venliped_cantidad"		
	CASE  "Sin Stock Suficiente"
		filtro = filtro + " and stock < venliped_cantidad or isnull (stock) or stock = 0"		
		
	CASE ELSE		
		//filtro = ""
END CHOOSE


		
dw_wow.setfilter(filtro)
dw_wow.filter()

dw_wow.setfocus()
end subroutine

on w_planificacion_tencer_wide_copy.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "menu_planificacion_tencer_wide" then this.MenuID = create menu_planificacion_tencer_wide
this.r_1=create r_1
this.r_5=create r_5
this.dw_listado_planificacion=create dw_listado_planificacion
this.dw_listado_ficha=create dw_listado_ficha
this.st_titulo=create st_titulo
this.dw_necesidades_cajas=create dw_necesidades_cajas
this.dw_necesidades_granillas=create dw_necesidades_granillas
this.dw_ficha_operacion=create dw_ficha_operacion
this.dw_listado_ficha2=create dw_listado_ficha2
this.st_mensajes=create st_mensajes
this.p_imagen=create p_imagen
this.dw_estructura_planificada=create dw_estructura_planificada
this.dw_2=create dw_2
this.st_piezas=create st_piezas
this.st_m2=create st_m2
this.st_1=create st_1
this.st_2=create st_2
this.dw_necesidad_esmalte_ink=create dw_necesidad_esmalte_ink
this.dw_aplicaciones=create dw_aplicaciones
this.cb_comprobar_tif=create cb_comprobar_tif
this.dw_informe_archivos=create dw_informe_archivos
this.dw_imagen=create dw_imagen
this.dw_imagenes_extra=create dw_imagenes_extra
this.tv_1=create tv_1
this.dw_documento_almacen1=create dw_documento_almacen1
this.uo_1=create uo_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_mensajes_envio=create st_mensajes_envio
this.sle_articulo=create sle_articulo
this.st_articulo=create st_articulo
this.dw_wow=create dw_wow
this.dw_1=create dw_1
this.ddlb_familias=create ddlb_familias
this.cbx_ver_imagen=create cbx_ver_imagen
this.dw_totales=create dw_totales
this.cbx_estructura=create cbx_estructura
this.cbx_aplicaciones=create cbx_aplicaciones
this.cbx_arbol=create cbx_arbol
this.cbx_promo=create cbx_promo
this.ddlb_filtros=create ddlb_filtros
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_1
this.Control[iCurrent+2]=this.r_5
this.Control[iCurrent+3]=this.dw_listado_planificacion
this.Control[iCurrent+4]=this.dw_listado_ficha
this.Control[iCurrent+5]=this.st_titulo
this.Control[iCurrent+6]=this.dw_necesidades_cajas
this.Control[iCurrent+7]=this.dw_necesidades_granillas
this.Control[iCurrent+8]=this.dw_ficha_operacion
this.Control[iCurrent+9]=this.dw_listado_ficha2
this.Control[iCurrent+10]=this.st_mensajes
this.Control[iCurrent+11]=this.p_imagen
this.Control[iCurrent+12]=this.dw_estructura_planificada
this.Control[iCurrent+13]=this.dw_2
this.Control[iCurrent+14]=this.st_piezas
this.Control[iCurrent+15]=this.st_m2
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.dw_necesidad_esmalte_ink
this.Control[iCurrent+19]=this.dw_aplicaciones
this.Control[iCurrent+20]=this.cb_comprobar_tif
this.Control[iCurrent+21]=this.dw_informe_archivos
this.Control[iCurrent+22]=this.dw_imagen
this.Control[iCurrent+23]=this.dw_imagenes_extra
this.Control[iCurrent+24]=this.tv_1
this.Control[iCurrent+25]=this.dw_documento_almacen1
this.Control[iCurrent+26]=this.uo_1
this.Control[iCurrent+27]=this.cb_2
this.Control[iCurrent+28]=this.cb_1
this.Control[iCurrent+29]=this.sle_1
this.Control[iCurrent+30]=this.st_mensajes_envio
this.Control[iCurrent+31]=this.sle_articulo
this.Control[iCurrent+32]=this.st_articulo
this.Control[iCurrent+33]=this.dw_wow
this.Control[iCurrent+34]=this.dw_1
this.Control[iCurrent+35]=this.ddlb_familias
this.Control[iCurrent+36]=this.cbx_ver_imagen
this.Control[iCurrent+37]=this.dw_totales
this.Control[iCurrent+38]=this.cbx_estructura
this.Control[iCurrent+39]=this.cbx_aplicaciones
this.Control[iCurrent+40]=this.cbx_arbol
this.Control[iCurrent+41]=this.cbx_promo
this.Control[iCurrent+42]=this.ddlb_filtros
end on

on w_planificacion_tencer_wide_copy.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.r_1)
destroy(this.r_5)
destroy(this.dw_listado_planificacion)
destroy(this.dw_listado_ficha)
destroy(this.st_titulo)
destroy(this.dw_necesidades_cajas)
destroy(this.dw_necesidades_granillas)
destroy(this.dw_ficha_operacion)
destroy(this.dw_listado_ficha2)
destroy(this.st_mensajes)
destroy(this.p_imagen)
destroy(this.dw_estructura_planificada)
destroy(this.dw_2)
destroy(this.st_piezas)
destroy(this.st_m2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_necesidad_esmalte_ink)
destroy(this.dw_aplicaciones)
destroy(this.cb_comprobar_tif)
destroy(this.dw_informe_archivos)
destroy(this.dw_imagen)
destroy(this.dw_imagenes_extra)
destroy(this.tv_1)
destroy(this.dw_documento_almacen1)
destroy(this.uo_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_mensajes_envio)
destroy(this.sle_articulo)
destroy(this.st_articulo)
destroy(this.dw_wow)
destroy(this.dw_1)
destroy(this.ddlb_familias)
destroy(this.cbx_ver_imagen)
destroy(this.dw_totales)
destroy(this.cbx_estructura)
destroy(this.cbx_aplicaciones)
destroy(this.cbx_arbol)
destroy(this.cbx_promo)
destroy(this.ddlb_filtros)
end on

event open;call super::open;string des_empresa


istr_parametros.s_titulo_ventana = "Planificación"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_estructura_planificada.SetTransObject(SQLCA)
dw_aplicaciones.SetTransObject(SQLCA)
dw_wow.SetTransObject(SQLCA)


f_activar_campo(uo_1.em_codigo)
uo_1.em_codigo.text = "1"

/*
permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
	case 1
		menu_planificacion_tencer.m_archivo.m_grabar.disable()
//		menu_planificacion_tencer.m_herramientas.m_borrarseleccin.disable()
		menu_planificacion_tencer.m_herramientas.m_moverantes.disable()
		menu_planificacion_tencer.m_herramientas.m_moverdespus.disable()
		menu_planificacion_tencer.m_herramientas.m_borrarot.disable()
		menu_planificacion_tencer.m_herramientas.m_moverdespus.disable()
		menu_planificacion_tencer.m_procesos.disable()
		menu_planificacion_tencer.m_procesos.m_generar1.disable()
		menu_planificacion_tencer.m_seleccionar.disable()
		menu_planificacion_tencer.m_herramientas.m_borrarOT2.disable()

end choose
*/

select nombre
into :des_empresa
from empresas 
where empresa = :codigo_empresa;

st_titulo.text = des_empresa

//dw_1.SetRowFocusIndicator(FocusRect!)
end event

event ue_recuperar;

dw_1.Retrieve(codigo_empresa, uo_1.em_codigo.Text)

CALL Super::ue_recuperar
end event

event close;call super::close;string v_usuario

v_usuario = nombre_usuario

update planificacion 
set usuario = "", ordenmarcado = 0
where empresa = :codigo_empresa
and usuario = :v_usuario;

if SQLCA.SQLCode = 0 then
	commit;
else
	rollback;
end if


//dw_1.Retrieve(codigo_empresa,w_planificacion.sle_valor.text)








end event

event activate;call super::activate;w_planificacion_tencer_wide = ventanas_activas[id_ventana_activa].ventana
//Messagebox("Debug",id_ventana_activa)

//PERMISOS NUEVOS
if permiso_ventana <> 2 then
	//Solo lectura y casos no contemplados
	menu_planificacion_tencer_wide.m_archivo.m_grabar.disable()
	//menu_planificacion_tencer_wide.m_herramientas.m_borrarseleccin.disable()
	menu_planificacion_tencer_wide.m_herramientas.m_moverantes.disable()
	menu_planificacion_tencer_wide.m_herramientas.m_moverdespus.disable()
	menu_planificacion_tencer_wide.m_herramientas.m_borrarot.disable()
	menu_planificacion_tencer_wide.m_herramientas.m_moverdespus.disable()
	menu_planificacion_tencer_wide.m_procesos.disable()
	menu_planificacion_tencer_wide.m_procesos.m_generar1.disable()
	menu_planificacion_tencer_wide.m_seleccionar.disable()
	menu_planificacion_tencer_wide.m_herramientas.m_borrarOT2.disable()
	menu_planificacion_tencer_wide.m_herramientas.m_consultas.m_enviarainkcid.disable()
end if
end event

event timer;call super::timer;string ruta_pendiente = "\\AMAZONAS\HOTFOLDERS\CONVERSION\CONVERTIDO\PENDIENTE\"
string ruta_ink02 = "\\AMAZONAS\HOTFOLDERS\INK-02\"

st_mensajes_envio.text = "MOVIENDO A PROVISIONAL ..."

ftc_ejecutar_concurrente  ('C:\TENCER_PB12\mover.bat', 2, true)

st_mensajes_envio.text = "ENVIANDO MODELOS MATE ..."

ftc_ejecutar_concurrente  ("xcopy /y "+ruta_pendiente+"*MEM*.* "+ruta_ink02+"INK02_MEM_ALTA_160714\", 2, TRUE)

st_mensajes_envio.text = "ENVIANDO MODELOS BRILLO ..."

ftc_ejecutar_concurrente  ("xcopy /y "+ruta_pendiente+"*BEB*.* "+ruta_ink02+"INK02_BEB_ALTA_160714\", 2, TRUE)

st_mensajes_envio.visible = false

timer (0)





end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_planificacion_tencer_wide_copy
integer y = 804
integer height = 144
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_planificacion_tencer_wide_copy
end type

type st_empresa from w_int_con_empresa`st_empresa within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 3246
integer y = 44
integer width = 178
integer height = 68
integer textsize = -8
end type

type r_1 from rectangle within w_planificacion_tencer_wide_copy
integer linethickness = 8
long fillcolor = 8388608
integer x = 46
integer y = 24
integer width = 544
integer height = 104
end type

type r_5 from rectangle within w_planificacion_tencer_wide_copy
integer linethickness = 8
long fillcolor = 8388608
integer x = 23
integer y = 160
integer width = 5655
integer height = 2524
end type

type dw_listado_planificacion from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 242
integer y = 2544
integer width = 1573
integer height = 280
integer taborder = 190
boolean bringtotop = true
string dataobject = "report_listado_planificacion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_ficha from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 91
integer y = 368
integer width = 718
integer height = 1076
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_titulo from statictext within w_planificacion_tencer_wide_copy
integer x = 3351
integer y = 32
integer width = 1847
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_necesidades_cajas from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 3273
integer y = 828
integer width = 2272
integer height = 432
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_listado_necesidades_cajas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_necesidades_granillas from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 3259
integer y = 488
integer width = 2249
integer height = 288
integer taborder = 90
boolean bringtotop = true
string dataobject = "report_listado_necesidades_granillas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ficha_operacion from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 736
integer y = 1584
integer width = 3753
integer height = 784
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ficha_operacion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado_ficha2 from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 1079
integer y = 520
integer width = 1093
integer height = 1004
integer taborder = 100
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_mensajes from statictext within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 6615
integer y = 36
integer width = 1422
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33471187
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type p_imagen from picture within w_planificacion_tencer_wide_copy
integer x = 7214
integer y = 3020
integer width = 786
integer height = 340
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_estructura_planificada from datawindow within w_planificacion_tencer_wide_copy
integer x = 6213
integer y = 140
integer width = 2464
integer height = 788
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_estructura_planificada"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
This.SetRow ( currentrow)
end event

event doubleclicked;long v_ot, fila_seleccionada
string linea, cod_linea
if dw_1.RowCount() > 0 then
	v_ot = dw_estructura_planificada.object.planificacion_ot[row]
	linea = dw_estructura_planificada.object.prodlineas_resumido[row]
	
	select codigo 
	into :cod_linea
	from prodlineas
	where resumido = :linea
	and empresa = :codigo_empresa;
	
	dw_1.retrieve(codigo_empresa,cod_linea)
	fila_seleccionada = Dw_1.Find ("ot = "+string(v_ot), 1, dw_1.RowCount() )
	dw_1.SelectRow ( fila_seleccionada, true )
	dw_1.ScrollToRow ( fila_seleccionada)
	
	uo_1.em_codigo.text = cod_linea
	uo_1.em_campo.text  = linea

//	close(parent)
end if

end event

type dw_2 from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 32
integer y = 3876
integer width = 3360
integer height = 816
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dw_art_ver_op_aplicaciones_reducido"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_piezas from statictext within w_planificacion_tencer_wide_copy
integer x = 7072
integer y = 36
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_m2 from statictext within w_planificacion_tencer_wide_copy
integer x = 7557
integer y = 36
integer width = 334
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_planificacion_tencer_wide_copy
integer x = 6821
integer y = 36
integer width = 247
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Piezas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_planificacion_tencer_wide_copy
integer x = 7383
integer y = 36
integer width = 165
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "M2:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_necesidad_esmalte_ink from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 2757
integer y = 1268
integer width = 2249
integer height = 288
integer taborder = 150
boolean bringtotop = true
string dataobject = "report_necesidad_esmalte_ink"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_aplicaciones from datawindow within w_planificacion_tencer_wide_copy
integer x = 6208
integer y = 936
integer width = 2459
integer height = 792
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_art_ver_op_aplicaciones_reducido"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;long v_ot, fila_seleccionada
string linea, cod_linea
if dw_1.RowCount() > 0 then
	v_ot = dw_estructura_planificada.object.planificacion_ot[row]
	linea = dw_estructura_planificada.object.prodlineas_resumido[row]
	
	select codigo 
	into :cod_linea
	from prodlineas
	where resumido = :linea
	and empresa = :codigo_empresa;
	
	dw_1.retrieve(codigo_empresa,cod_linea)
	fila_seleccionada = Dw_1.Find ("ot = "+string(v_ot), 1, dw_1.RowCount() )
	dw_1.SelectRow ( fila_seleccionada, true )
	dw_1.ScrollToRow ( fila_seleccionada)
	
	uo_1.em_codigo.text = cod_linea
//	des_linea.text = linea

//	close(parent)
end if

end event

event rowfocuschanged;This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
This.SetRow ( currentrow)
end event

type cb_comprobar_tif from commandbutton within w_planificacion_tencer_wide_copy
integer x = 8064
integer y = 8
integer width = 594
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "COMPROBAR TIF~'S"
end type

event clicked;string articulo, ver, operacion, modelo
long ordenoperacion, i, k
datastore regs
transaction trans_sql
string sel, tiff, origen, ruta_origen, disenyador, des_disenyador


ruta_origen = "\\amazonas\disenyo\produccion\"

w_planificacion_tencer_wide.dw_informe_archivos.reset()

f_crear_transaccion(trans_sql,"","",false,"TS","")
connect using trans_sql;

//sel = " select articulo, operacion  "+&
//		" from art_ver_op_aplicaciones "+&
//		" where empresa = '"+codigo_empresa+"' "+&
//		" and tipoaplicacion = '51' "+&
//		" and version = '1' "

sel = " select art_ver_op_aplicaciones.articulo, art_ver_op_aplicaciones.operacion  "+&
		" from art_ver_op_aplicaciones, articulos "+&
		" where art_ver_op_aplicaciones.empresa = '"+codigo_empresa+"' "+&
		" and art_ver_op_aplicaciones.empresa = articulos.empresa "+&
		" and art_ver_op_aplicaciones.articulo = articulos.codigo "+&
		" and articulos.fecha_anulado is null "+&
		" and art_ver_op_aplicaciones.tipoaplicacion = '51' "+&
		" and art_ver_op_aplicaciones.version = '1' "


f_cargar_cursor_nuevo (sel, regs)

k = 0
for i = 1 to regs.rowcount()
	articulo = regs.object.art_ver_op_aplicaciones_articulo[i] 
	operacion = regs.object.art_ver_op_aplicaciones_operacion[i] 
	ver = '1'
	
	select referencia_laboratorio
	into :modelo
	from articulos
	where empresa = :codigo_empresa
	and codigo = :articulo using trans_sql;
	
	select desmodelo.tecnico_dis, tecnico_dis.descripcion
	into :disenyador, :des_disenyador
	from desmodelo, tecnico_dis
	where desmodelo.modelo = :modelo
	and desmodelo.empresa = :codigo_empresa
	and desmodelo.empresa = tecnico_dis.empresa
	and desmodelo.tecnico_dis = tecnico_dis.codigo;

	SELECT art_ver_op_aplicaciones.tiff	  
	INTO :tiff
	FROM art_ver_op_aplicaciones LEFT OUTER JOIN prodaplicaciones ON art_ver_op_aplicaciones.empresa = prodaplicaciones.empresa AND art_ver_op_aplicaciones.tipoaplicacion = prodaplicaciones.codigo 
											LEFT OUTER JOIN prodpantallas ON art_ver_op_aplicaciones.empresa = prodpantallas.empresa AND art_ver_op_aplicaciones.pantalla = prodpantallas.codigo
											LEFT OUTER JOIN prodformula ON art_ver_op_aplicaciones.empresa = prodformula.empresa AND art_ver_op_aplicaciones.formula = prodformula.formula 
	WHERE ( art_ver_op_aplicaciones.empresa = :codigo_empresa ) AND  
	( art_ver_op_aplicaciones.articulo = :articulo ) AND  
	( art_ver_op_aplicaciones.version = :ver ) AND  
	( art_ver_op_aplicaciones.operacion = :operacion ) AND  
	( art_ver_op_aplicaciones.tipoaplicacion = '51' ) using trans_sql  ;
	
	origen = ruta_origen+modelo+"\T"+tiff+".tif"

	if not FileExists (origen) then
		k = dw_informe_archivos.insertrow(0)
		dw_informe_archivos.object.texto[k] = des_disenyador +"     ARTÍCULO: "+articulo+"     MODELO: "+modelo+"     TIFF: "+origen
		dw_informe_archivos.setsort('texto')
		dw_informe_archivos.sort()
	end if

	f_mensaje_proceso ("Reg: ", i , regs.rowcount())
next


IF trans_sql.sqlcode <> 0 THEN
	messagebox ("Error","Error Copiando Archivos. Avise al administrador. Detalles: "+trans_sql.SQLErrText)
	ROLLBACK USING trans_sql;
	DISCONNECT USING trans_sql;
ELSE
	COMMIT USING trans_sql;
END IF
	
destroy trans_sql

if dw_informe_archivos.rowcount() > 0 then
	dw_informe_archivos.retrieve()
	dw_informe_archivos.visible = true;
	f_imprimir_datawindow(	dw_informe_archivos)
end if


end event

type dw_informe_archivos from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 983
integer y = 180
integer width = 3552
integer height = 3524
integer taborder = 160
string title = "none"
string dataobject = "dw_informe_archivos"
boolean livescroll = true
end type

event doubleclicked;this.visible = false
end event

type dw_imagen from u_dw_imagen within w_planificacion_tencer_wide_copy
integer x = 6235
integer y = 3016
integer width = 960
integer height = 696
integer taborder = 200
boolean bringtotop = true
end type

type dw_imagenes_extra from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 2418
integer y = 168
integer width = 686
integer height = 392
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_imagen_encajado"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tv_1 from treeview within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 6213
integer y = 1728
integer width = 2459
integer height = 1276
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event rightclicked;Long id_ventana
str_parametros lstr_param 
string codigo_nuevo
Treeviewitem tvi


this.getitem(handle,tvi)

codigo_nuevo = Mid(tvi.label, Pos (tvi.label, "[") + 1,  ( Pos (tvi.label, "]") - Pos (tvi.label, "[")) - 1)  	

lstr_param.i_nargumentos=2
lstr_param.s_argumentos[1]="w_planificacion_tencer_wide"
lstr_param.s_argumentos[2]=codigo_nuevo
OpenWithParm(w_mant_altas_intermedios_nuevo,lstr_param)
end event

type dw_documento_almacen1 from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 3415
integer y = 1468
integer width = 1874
integer height = 1428
integer taborder = 220
boolean bringtotop = true
string title = "none"
string dataobject = "dw_documento_almacen1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from u_em_campo_2 within w_planificacion_tencer_wide_copy
integer x = 59
integer y = 32
integer width = 512
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_1.em_campo.text=f_nombre_linea_abr(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 
dw_1.Retrieve(codigo_empresa, uo_1.em_codigo.text)	

dw_wow.visible = false
//dw_wow.retrieve (codigo_empresa, familia, fecha1, fecha2)

if dw_wow.visible then
	f_ocultar_controles()
else
	f_mostrar_controles()
end if

ddlb_familias.text = ''
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Líneas de Producción"
ue_datawindow ="dw_ayuda_prodlineas"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type cb_2 from commandbutton within w_planificacion_tencer_wide_copy
integer x = 1147
integer y = 24
integer width = 133
integer height = 96
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;string familia []
datetime fecha1, fecha2 , fecha3
int dias1 = 90
int dias2 = 30
int dias3 = 60
int i
string articulo
dec stock

choose case ddlb_familias.text 
	case "MARCAS"
		familia[1] = "2"

	case "CUSTOM MADE"
		familia[1] = "3"
	
	case "DECORACION"
		familia[1] = "1"
		
	case "Todo"
		familia[1] = '2'
		familia[2] = '1'
		familia[3] = '3'
end choose

fecha1 = datetime( relativedate (today(), -dias1))
fecha2 = datetime( relativedate (today(), -dias2))
fecha3 = datetime( relativedate (today(), -dias3))

//dw_wow.visible = not dw_wow.visible
dw_wow.retrieve (codigo_empresa, familia, fecha1, fecha2, fecha3)

//if dw_wow.visible then
//	f_ocultar_controles()
//else
//	f_mostrar_controles()
//end if

f_filtrar_wow()


/*
string familia = '2'
datetime fecha1, fecha2 
int dias1 = 90
int dias2 = 30
int i
string articulo
dec stock

fecha1 = datetime( relativedate (today(), -dias1))
fecha2 = datetime( relativedate (today(), -dias2))

dw_wow.visible = not dw_wow.visible
dw_wow.retrieve (codigo_empresa, familia, fecha1, fecha2)

if dw_wow.visible then
	f_ocultar_controles()
else
	f_mostrar_controles()
end if

f_filtrar_wow()

*/
end event

type cb_1 from commandbutton within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 6139
integer y = 88
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "pruebas"
end type

event clicked;string articulo
dec factor_acumulado = 1
dec cantidad = 1000
int anyo, pedido, linped

//articulo = dw_1.object.cod_articulo [ dw_1.getrow()]

pedido = 0
linped = f_numero_linea_pedido_interno()
anyo = year(today())

articulo = sle_1.text
ftc_planificar_Articulo (articulo, cantidad, factor_acumulado, articulo, anyo, pedido, linped)
end event

type sle_1 from singlelineedit within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 5728
integer y = 84
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_mensajes_envio from statictext within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 3328
integer y = 20
integer width = 1897
integer height = 100
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217857
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_articulo from singlelineedit within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 5609
integer y = 28
integer width = 951
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event losefocus;string filtro = ''

if sle_articulo.text <> '' then
	filtro = "upper(articulos_descripcion) like'%"+sle_articulo.text+"%' "
else
	filtro = "upper(articulos_descripcion) like '%'"
end if

dw_wow.setfilter(filtro)
dw_wow.filter()

end event

type st_articulo from statictext within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 5289
integer y = 40
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Artículo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_wow from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 23
integer y = 164
integer width = 8658
integer height = 3676
integer taborder = 120
string title = "none"
string dataobject = "dw_situacion_articulos_wow"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;long i


if dwo.name = 't_articulo' then
	this.SetSort("articulos_descripcion A")
	this.Sort()
end if	             

if dwo.name = 't_formato' then
	this.SetSort("formatos_descripcion A ")
	this.Sort()
end if	             

if dwo.name = 't_lote_minimo' then
	this.SetSort("articulos_lote_minimo D")
	this.Sort()
end if	             


if dwo.name = 't_cantidad' then
	this.SetSort("venliped_cantidad D")
	this.Sort()
end if	             

if dwo.name = 't_stock' then
	this.SetSort("stock_bis D")
	this.Sort()
end if	             

if dwo.name = 't_stock_min' then
	this.SetSort("articulos_Stock_min D")
	this.Sort()
end if	             

if dwo.name = 't_stock_disponible' then
	this.SetSort("stock_disponible D")
	this.Sort()
end if	             

if dwo.name = 't_stock_pedido' then
	this.SetSort("ped_menos_stock D")
	this.Sort()
end if	             

if dwo.name = 't_planificado' then
	this.SetSort("planificado_bis D")
	this.Sort()
end if	             

if dwo.name = 't_rotura' then
	this.SetSort("rotura A")
	this.Sort()
end if	             

if dwo.name = 't_consumo1' then
	this.SetSort("consumo_bis D")
	this.Sort()
end if	   

if dwo.name = 't_consumo1_m2' then
	this.SetSort("consumo_bis_m2 D")
	this.Sort()
end if	   


if dwo.name = 't_consumo2' then
	this.SetSort("consumo_min_bis D")
	this.Sort()
end if	   

if dwo.name = 't_disp_m2' then
	this.SetSort("disp_m2 D")
	this.Sort()
end if	      

if dwo.name = 't_sugerido_m2' then
	this.SetSort("sugerido_m2 D")
	this.Sort()
end if	             

if dwo.name = 't_sugerido' then
	this.SetSort("sugerido D")
	this.Sort()
end if	             

if dwo.name = 'b_marcar' then
	for i = 1 to this.rowcount() 
		this.object.marcado[i] = 'S'
	next
end if	             

if dwo.name = 'b_desmarcar' then
	for i = 1 to this.rowcount() 
		this.object.marcado[i] = 'N'
	next
end if	             

if dwo.name = 'b_planificar' then
	for i = 1 to this.rowcount() 
		if ( ( this.object.sugerido[i] = 0 or  isnull (this.object.sugerido[i] ) ) and  ( this.object.sugerido2[i] = 0 or isnull (this.object.sugerido2[i] ) ) ) 	 then
			this.object.marcado[i] = 'N'
		end if
	next
	if cbx_promo.checked then
		// f_planificar_articulo()
	else
		f_planificar_wow()
	end if
end if	             


string articulo
dec stock

if dwo.name = 'b_stock_base' then
	for i = 1 to dw_wow.rowcount()
		articulo = dw_wow.object.articulos_codigo[i]
		 stock = f_calculo_stock_base_articulo ( articulo)
		 
		st_mensajes.visible = true
		st_mensajes.text = "Artículo "+string(i)+" de "+string(dw_wow.rowcount())
		
		dw_wow.object.stock_biz[i] = stock 
	next	
	st_mensajes.text = ""
	st_mensajes.visible = false
		
end if	             


end event

event rbuttondown;/*
str_escandallo vector_escandallo[300]
integer  indice = 1 , factor_acumulado = 1, nivel
string articulo, base
integer i
string uso, des_base
dec stock

articulo= this.object.articulos_codigo[row]
f_escandallo_factores_con_sin_base(vector_Escandallo, articulo, indice, factor_acumulado, nivel, true)	

i = 1
do while i < 300 and uso <> '1'
	base = vector_escandallo[i].articulo
	select uso,  descripcion 
	into :uso, :des_base
	from articulos
	where empresa = :codigo_empresa
	and codigo = :base;
	
	i++
loop

select sum(cantidade- cantidads)
into :stock
from almacenmovimientos
where empresa =:codigo_empresa
and articulo = :base;

messagebox ("Stock Base", base+"   "+des_base+":   "+string (stock, "###,###,##0"))
*/
end event

type dw_1 from u_datawindow within w_planificacion_tencer_wide_copy
integer x = 37
integer y = 160
integer width = 6158
integer height = 3656
integer taborder = 140
string dataobject = "dw_planificacion_tencer_wide"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

event doubleclicked;dec v_ot
dec v_ordenmarcado
long i, seleccionados, v_orden, fila_inicial
decimal m2, piezas

v_ot = dw_1.object.ot[Row]

if  dw_1.object.planificacion_usuario[Row]  = nombre_usuario then
	dw_1.object.planificacion_usuario[Row] = ""
	update planificacion
	set usuario = ""
	where ot = :v_ot;
	
	if SQLCA.SQLCode = 0 then
		commit;
	else
		messagebox ("ERROR","No se puede desmarcar el registro")
		rollback;
	end if
else
	v_ordenmarcado = 0
	select max (ordenmarcado)
	into :v_ordenmarcado
	from planificacion;
	v_ordenmarcado = v_ordenmarcado+1
	
	dw_1.object.planificacion_usuario[Row] = nombre_usuario
	dw_1.object.ordenmarcado[Row] = int(v_ordenmarcado)
	dw_1.object.planificacion_usuario.Color = RGB(0, 0, 255)

	update planificacion
	set usuario = :nombre_usuario, ordenmarcado = :v_ordenmarcado
	where ot = :v_ot;
	
	if SQLCA.SQLCode = 0 then
		commit;
	else
		messagebox ("ERROR","No se puede marcar el registro")
		rollback;
	end if
end if

piezas = 0
m2 = 0
for i=1 to w_planificacion_tencer_wide.dw_1.rowcount()
	if w_planificacion_tencer_wide.dw_1.object.planificacion_usuario[i]  = nombre_usuario then
		piezas += w_planificacion_tencer_wide.dw_1.object.planificacion_cantidad[i]
		m2 += w_planificacion_tencer_wide.dw_1.object.m2[i]
	end if		
next

m2 = round (m2, 2)


w_planificacion_tencer_wide.st_piezas.text = string(piezas)
w_planificacion_tencer_wide.st_m2.text = string(m2)
end event

event clicked;call super::clicked;This.SelectRow(0, false)
This.SelectRow(row, TRUE)
this.SetRow(row)




end event

event rowfocuschanged;call super::rowfocuschanged;long pedido, linped, anyo
str_escandallo escandallo[50]
long v_ot, fila_seleccionada
string linea, cod_linea, v_Articulo, ver, ordenoperacion
string v_operacion, base
string pieza_origen = "", coleccion_origen = "", modelo_origen = "", articulo, ruta
	

This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
This.SetRow ( currentrow)

if cbx_ver_imagen.checked then
	p_imagen.visible = true
	p_imagen.PictureName = ""
	IF dw_1.GetRow() > 0 then
		p_imagen.PictureName = f_cargar_imagen_nuevo(string(dw_1.object.articulos_codigo_pantallas[dw_1.GetRow()]))
		//NUEVO
		articulo = dw_1.object.cod_articulo[dw_1.getrow()]
		
		if not isnull(articulo) and articulo <> "" then
			ruta = ftc_imagen_articulo_ruta("5", articulo)	
			if ruta <> "" then
				dw_imagen.Object.datawindow.picture.File =  ruta
				p_imagen.PictureName = ""
				dw_imagen.visible = true
			else
				if ftc_articulo_base2(articulo, base) then
					ruta = ftc_imagen_articulo_ruta("1", base)
					if ruta <> "" then
						dw_imagen.Object.datawindow.picture.File = ruta
						p_imagen.PictureName = ""
						dw_imagen.visible = true
					else
						dw_imagen.visible = false
					end if
				else
					dw_imagen.visible = false
				end if
			end if
		else
			dw_imagen.visible = false
		end if
	else
		p_imagen.PictureName = ""
		dw_imagen.visible = false
	END IF
else
	p_imagen.visible = false
end if


if cbx_estructura.checked and  dw_1.rowcount() > 0 then
	dw_estructura_planificada.visible = true
	pedido = dw_1.object.pedido[currentrow]
	linped = dw_1.object.linped[currentrow]
	anyo = dw_1.object.planificacion_anyo[currentrow]
	
	if dw_estructura_planificada.visible then
		dw_estructura_planificada.retrieve (codigo_empresa, anyo, pedido, linped)
	end if
	if dw_estructura_planificada.RowCount() > 0 then
		v_ot = dw_1.object.ot[currentrow]

		fila_seleccionada = dw_estructura_planificada.Find ("planificacion_ot = "+string(v_ot), 1, dw_estructura_planificada.RowCount() )
		dw_estructura_planificada.SelectRow ( fila_seleccionada, true )
		dw_estructura_planificada.ScrollToRow ( fila_seleccionada)
	end if
	
else
	dw_estructura_planificada.visible = false
end if

if cbx_aplicaciones.checked and dw_1.rowcount() > 0 then
	
	dw_aplicaciones.visible = true
	v_articulo = dw_1.object.cod_articulo[currentrow]
	ver = dw_1.object.planificacion_version[currentrow]
	ordenoperacion = string (dw_1.object.planificacion_ordenoperacion[currentrow])

	select operacion
	into :v_operacion
	from art_ver_operaciones 
	where articulo = :v_articulo
	and version = :ver
	and orden = :ordenoperacion
	and empresa = :codigo_empresa;
	
	if dw_aplicaciones.visible then
		dw_aplicaciones.retrieve (codigo_empresa, v_articulo, ver, v_operacion)
	end if
else
	dw_aplicaciones.visible = false
end if

// Mostramos el escandallo
if cbx_arbol.checked then
	tv_1.visible = true
	if currentrow <> 0 then
		if this.object.cod_articulo[currentrow] <> "" then
			tv_1.deleteitem(0)
			f_escandallo_treeview( this.object.cod_articulo[currentrow], 0, tv_1)
		end if
		this.selectrow(0,false)
		this.selectrow(currentrow,true)
	else
		if this.rowcount() > 0 then
			this.selectrow(0,false)
			this.selectrow(1,true)
			tv_1.deleteitem(0)
			f_escandallo_treeview( this.object.cod_articulo[1], 0, tv_1)
		else
			tv_1.deleteitem(0)
		end if
	end if
else
	tv_1.visible = false
end if


end event

event rbuttondown;/*
m_prueba1 m

m = CREATE m_prueba1

m.popmenu(w_planificacion_tencer_wide.pointerx(), w_planificacion_tencer_wide.pointery())

destroy m
*/


menu_planificacion_tencer_wide.m_herramientas.m_consultas.popmenu(Parent.pointerx(), Parent.pointery())

//Messagebox("Aviso", "Botón secundario deshabilitado temporalmente en planificación. Para realizar las acciones de este menú haga clic en Herramientas -> Consultas del menú superior.")
end event

event buttonclicked;call super::buttonclicked;String planificado 
Dec pedido 
Int anyo, linea
this.accepttext()


if row > 0 then
	if dwo.name = "b_pedido" then
		planificado = this.object.venliped_planificado[row]
		anyo = this.object.planificacion_anyo[row]
		pedido = this.object.pedido[row]
		linea = this.object.linped[row]
		if planificado = 'S' then
			UPDATE venliped SET planificado = 'N' WHERE anyo = :anyo AND pedido = :pedido AND linea = :linea;
		elseif planificado = 'N' then
			UPDATE venliped SET planificado = 'S' WHERE anyo = :anyo AND pedido = :pedido AND linea = :linea;
		end if
		
		SELECT planificado INTO :planificado FROM venliped WHERE anyo = :anyo AND pedido = :pedido AND linea = :linea;
		this.object.venliped_planificado[row] = planificado
		
	end if
end if

this.accepttext()
end event

type ddlb_familias from dropdownlistbox within w_planificacion_tencer_wide_copy
integer x = 599
integer y = 20
integer width = 535
integer height = 400
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
boolean sorted = false
string item[] = {"Todo","MARCAS","CUSTOM MADE","DECORACION"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_wow.visible = true
//dw_wow.retrieve (codigo_empresa, familia, fecha1, fecha2)

if dw_wow.visible then
	f_ocultar_controles()
else
	f_mostrar_controles()
end if

uo_1.em_campo.text=""
uo_1.em_codigo.text=""
dw_wow.reset()

end event

type cbx_ver_imagen from checkbox within w_planificacion_tencer_wide_copy
integer x = 1426
integer y = 32
integer width = 402
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver Imagen"
boolean checked = true
end type

event clicked;p_imagen.visible = cbx_ver_imagen.checked

//cbx_aplicaciones.checked = not cbx_ver_imagen.checked 
//dw_aplicaciones.visible = not cbx_ver_imagen.checked 

if cbx_ver_imagen.checked then
//	cbx_aplicaciones.checked = false
	dw_aplicaciones.visible = false
end if
end event

type dw_totales from datawindow within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 1367
integer y = 20
integer width = 219
integer height = 92
integer taborder = 170
string dataobject = "report_listado_planificacion_totales"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_estructura from checkbox within w_planificacion_tencer_wide_copy
integer x = 1897
integer y = 32
integer width = 379
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estructura"
boolean checked = true
end type

event clicked;dw_estructura_planificada.visible = cbx_estructura.checked

end event

type cbx_aplicaciones from checkbox within w_planificacion_tencer_wide_copy
integer x = 2322
integer y = 32
integer width = 430
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aplicaciones"
boolean checked = true
end type

event clicked;dw_aplicaciones.visible = cbx_aplicaciones.checked
//cbx_ver_imagen.checked = not cbx_aplicaciones.checked
//p_imagen.visible = not cbx_aplicaciones.checked

if cbx_aplicaciones.checked then
//	cbx_ver_imagen.checked = false
	p_imagen.visible = false
end if
end event

type cbx_arbol from checkbox within w_planificacion_tencer_wide_copy
integer x = 2793
integer y = 32
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Arbol"
end type

type cbx_promo from checkbox within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 2185
integer y = 32
integer width = 558
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar Promoción"
end type

event clicked;f_filtrar_wow()
end event

type ddlb_filtros from dropdownlistbox within w_planificacion_tencer_wide_copy
boolean visible = false
integer x = 1403
integer y = 20
integer width = 759
integer height = 400
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Todos","Rotura Stock","Con Stock Suficiente","Sin Stock Suficiente"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;f_filtrar_wow()
end event

