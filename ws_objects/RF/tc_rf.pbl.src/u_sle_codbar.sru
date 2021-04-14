$PBExportHeader$u_sle_codbar.sru
forward
global type u_sle_codbar from userobject
end type
type p_validar from picture within u_sle_codbar
end type
type p_bajar from picture within u_sle_codbar
end type
type p_subir from picture within u_sle_codbar
end type
type sle_codbar_ubicacion from singlelineedit within u_sle_codbar
end type
type st_lectura_ubicacion from statictext within u_sle_codbar
end type
type st_lectura_caja_bulto from statictext within u_sle_codbar
end type
type sle_codbar_caja_bulto from singlelineedit within u_sle_codbar
end type
type pb_teclado from picturebutton within u_sle_codbar
end type
type dw_detalle_bultos from datawindow within u_sle_codbar
end type
type pb_ver_detalle_bulto from picturebutton within u_sle_codbar
end type
type st_descripcion from statictext within u_sle_codbar
end type
type sle_codbar from singlelineedit within u_sle_codbar
end type
type st_texto from statictext within u_sle_codbar
end type
type p_codbar from picture within u_sle_codbar
end type
end forward

global type u_sle_codbar from userobject
integer width = 4626
integer height = 916
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event getfocus pbm_ensetfocus
event clicked pbm_bnclicked
event modified pbm_enmodified
event ue_refrescar ( )
event ue_siguiente_objeto ( )
event ue_anterior_objeto ( )
event timer pbm_timer
event ue_pre_siguiente_objeto ( )
p_validar p_validar
p_bajar p_bajar
p_subir p_subir
sle_codbar_ubicacion sle_codbar_ubicacion
st_lectura_ubicacion st_lectura_ubicacion
st_lectura_caja_bulto st_lectura_caja_bulto
sle_codbar_caja_bulto sle_codbar_caja_bulto
pb_teclado pb_teclado
dw_detalle_bultos dw_detalle_bultos
pb_ver_detalle_bulto pb_ver_detalle_bulto
st_descripcion st_descripcion
sle_codbar sle_codbar
st_texto st_texto
p_codbar p_codbar
end type
global u_sle_codbar u_sle_codbar

type variables
//Parametros del objeto
string is_tipo_codigo = 'EAN13' //Posibles valores EAN13,EAN128
boolean ib_permitir_ir_atras = true
boolean ib_mostrar_desplegado = false
boolean ib_permitir_desplegar = true
boolean ib_obligatorio_marcar_una_linea = false
boolean ib_lanzar_modified = true
string is_descripcion
long   il_height_maximo = 912,il_height_minimo = 152
//Ubicacion
long   il_id_ubicacion
string is_almacen,is_zona
int    ii_fila,ii_altura
int    ii_bultos,ii_lineas_bulto,ii_indice_lineas_bulto
boolean ib_ubicacion_con_bulto_asociado = false
boolean ib_ubicacion_gestionada_en_piezas = false
boolean ib_ubicacion_permite_reservas = true
boolean ib_pedir_ubicacion_si_el_bulto_no_la_tiene = false
str_almubimapa_codbar istr_almubimapa_codbar
//Bulto
long   il_id_bulto,il_piezas,il_linea_orden_carga,il_alm_bultos_lineas_id,il_piezas_reservadas_bulto,il_piezas_disponibles_totales,il_piezas_disponibles_bulto
string is_codigo_articulo,is_codigo_caja,is_codigo_pallet,is_codigo_calidad,is_lote,is_orden_carga
int    ii_calibre,ii_anyo_orden_carga
long    il_id_alm_orden_carga_bulto,il_id_alm_orden_preparacion_bulto
boolean ib_bulto_asociado_a_orden_de_carga = false
//Articulo
string is_descripcion_articulo
str_articulos istr_articulos, istr_articulos_vacio
str_almartcajas istr_almartcajas, istr_almartcajas_vacio
str_palarticulo istr_palarticulo, istr_palarticulo_vacio
//Ubicacion Sugerida
long   il_id_ubicacion_sugerida
string is_almacen_sugerida,is_zona_sugerida,is_filto_ubicaciones_sugeridas_descartadas
int    ii_fila_sugerida,ii_altura_sugerida
long   ll_color_fondo_texto,ll_color_texto_texto 
boolean ib_sugiriendo_ubicacion = false,ib_insertando_row = false
u_sle_codbar iu_sle_codbar_ubicacion_sugiero


end variables
forward prototypes
public subroutine f_leer_ubicacion ()
public subroutine f_leer_bulto ()
public subroutine f_leer_ean128 ()
public subroutine f_leer_articulo ()
public subroutine f_inicializar_variables_instancia ()
public function long f_setrow (long row)
public function integer f_reset ()
public function integer f_sugerir_ubicacion_destino (u_sle_codbar arg_u_sle_codbar_a_ubicar)
public subroutine f_leer_ean128_eng ()
public subroutine f_leer_ean128_caja_bulto ()
public subroutine f_leer_ean128_eng_caja_bulto ()
public subroutine f_leer_ubicacion_para_bulto ()
public function boolean f_cambia_ubicacion_bulto ()
public subroutine f_calculo_disponible_linea ()
public function boolean f_asignar_nueva_ubicacion (long arg_id_ubicacion_nueva)
public subroutine f_leer_ean128_prov ()
public subroutine f_leer_ean128_prov_caja_bulto ()
public subroutine f_leer_ean128_prov_eng ()
public subroutine f_leer_ean128_prov_eng_caja_bulto ()
public subroutine f_leer_ean128_sin_parentesis ()
public subroutine f_leer_ean128_sin_parentesis_eng ()
public subroutine f_leer_ean128_caja_bulto_sin_parentesis ()
public subroutine f_leer_ean128_caja_bulto_sin_parente_eng ()
public subroutine f_orden_carga_asociada_a_bulto ()
public subroutine f_orden_preparacion_asociada_a_bulto ()
end prototypes

event getfocus;f_reset()

st_texto.backcolor = rgb(0,128,0)

p_codbar.enabled = true
st_texto.enabled = true
sle_codbar.enabled = true
pb_ver_detalle_bulto.enabled = true
//pb_atras.enabled = true
//pb_atras.visible = false

sle_codbar.setfocus()
sle_codbar.event getfocus()
end event

event clicked;this.event getfocus()
end event

event ue_refrescar();sle_codbar.event modified()
end event

event ue_siguiente_objeto();//Escribir aqui el script para pasar de objeto cuando la lectura haya sido correcta
//siguiente_objeto.SetFocus()
st_texto.backcolor = rgb(83,99,110)

p_codbar.enabled = false
st_texto.enabled = false
sle_codbar.enabled = false
pb_ver_detalle_bulto.enabled = false
//pb_atras.enabled = false
//pb_atras.visible = false
end event

event ue_anterior_objeto();//Escribir aqui el script para pasar de objeto cuando se pulse el boton anterior
//anterior_objeto.SetFocus()
end event

event timer;//Timer
end event

event ue_pre_siguiente_objeto();//Evento que se lanza cuando leo un bulto con contenido variado
//previo a la lectura del ean de una de las cajas del bulto 
end event

public subroutine f_leer_ubicacion ();/*		 
//Ubicacion
long   il_id_ubicacion
string is_almacen,is_zona
int    ii_fila,ii_altura
//Bulto
long   il_id_bulto
string is_codigo_articulo,is_codigo_caja,is_codigo_calidad,is_lote
int    ii_calibre		 
*/
string ls_ean13,ls_activo,ls_gestionar_en_piezas,ls_permitir_reservas 
long   ll_color_fondo,ll_color_texto 

string ls_almacen,ls_zona
int    li_fila,li_altura
long   ll_id_ubicacion,ll_rows
long   ll_almubimapa_codbar_id_alm_bultos

ls_ean13 = this.sle_codbar.text

f_inicializar_variables_instancia()

select isnull(almubimapa_codbar.almacen,''),
		 isnull(almubimapa_codbar.zona,''),
		 isnull(almubimapa_codbar.fila,''),
		 isnull(almubimapa_codbar.altura,''),
		 isnull(almubimapa_codbar.id,0),
		 isnull(almubimapa_codbar.activo,''),
		 isnull(almubimapa_codbar.color_fondo,0),
		 isnull(almubimapa_codbar.color_texto,0), 
		 isnull(almubimapa_codbar.id_alm_bultos,0), 
		 isnull(almubimapa_codbar.gestionar_en_piezas,''), 
		 isnull(almubimapa_codbar.permitir_reservas,'') 
into   :is_almacen,
		 :is_zona,
		 :ii_fila,
		 :ii_altura,
		 :il_id_ubicacion,
		 :ls_activo,
		 :ll_color_fondo, 
		 :ll_color_texto, 
		 :ll_almubimapa_codbar_id_alm_bultos, 
		 :ls_gestionar_en_piezas,
		 :ls_permitir_reservas 
from   almubimapa_codbar 
where  almubimapa_codbar.empresa = :codigo_empresa 
and    almubimapa_codbar.ean13   = :ls_ean13;

f_cargar_str_almubimapa_codbar(il_id_ubicacion,istr_almubimapa_codbar)
f_inicializar_str_almubimapa_codbar(istr_almubimapa_codbar)

if ll_almubimapa_codbar_id_alm_bultos > 0 then
	ib_ubicacion_con_bulto_asociado = true	
else
	ib_ubicacion_con_bulto_asociado = false
end if

if ls_gestionar_en_piezas = 'S' then
	ib_ubicacion_gestionada_en_piezas = true
else
	ib_ubicacion_gestionada_en_piezas = false
end if

if ls_permitir_reservas = 'N' then
	ib_ubicacion_permite_reservas = false
else
	ib_ubicacion_permite_reservas = true
end if

dw_detalle_bultos.setfilter("")
dw_detalle_bultos.filter()

//Vamos a ver cuantos bultos tenemos en la ubicacion
select isnull(count(distinct(alm_bultos.id)),0) 
into   :ii_bultos 
from   alm_bultos,alm_bultos_lineas 
where  alm_bultos.id           = alm_bultos_lineas.id_alm_bultos 
and    alm_bultos.empresa      = :codigo_empresa 
and    alm_bultos.id_ubicacion = :il_id_ubicacion;

if ii_bultos > 0 and ls_activo = "N" then
	ls_activo = "S"
end if

ib_lanzar_modified = false
ll_rows = dw_detalle_bultos.retrieve(codigo_empresa,il_id_ubicacion)
ib_lanzar_modified = true

if ll_rows > 0 then
	
	ii_lineas_bulto = dw_detalle_bultos.rowcount()
	ii_indice_lineas_bulto = 1

	f_setrow(1)
	/*ESTAS VARIABLES SE CARGAN EN EL ROWFOCUSCHANGED
	il_id_bulto     = dw_detalle_bultos.object.alm_bultos_id[1]
	ii_lineas_bulto = dw_detalle_bultos.rowcount()
	*/
	if ii_bultos = 1 and ii_lineas_bulto > 1 and ib_obligatorio_marcar_una_linea then
		dw_detalle_bultos.modify("datawindow.footer.height = 156")
		st_lectura_caja_bulto.visible = true
		sle_codbar_caja_bulto.visible = true
		p_subir.visible   = true
		p_validar.visible = true
		p_bajar.visible   = true

		sle_codbar_caja_bulto.setfocus()
	else
		dw_detalle_bultos.modify("datawindow.footer.height = 0")
		st_lectura_caja_bulto.visible = false
		sle_codbar_caja_bulto.visible = false
		sle_codbar_caja_bulto.text    = ""
		p_subir.visible   = false
		p_validar.visible = false
		p_bajar.visible   = false		
		
	end if	
		
//	if ii_lineas_bulto > 1 and ii_bultos = 1 then
//		dw_detalle_bultos.modify("datawindow.footer.height = 156")
//		st_lectura_caja_bulto.visible = true
//		sle_codbar_caja_bulto.visible = true
//		
//		sle_codbar_caja_bulto.setfocus()
//	else
//		dw_detalle_bultos.modify("datawindow.footer.height = 0")
//		st_lectura_caja_bulto.visible = false
//		sle_codbar_caja_bulto.visible = false
//		sle_codbar_caja_bulto.text    = ""
//	end if

else
	
	ls_almacen      = is_almacen
	ls_zona         = is_zona
	li_fila         = ii_fila
	li_altura       = ii_altura
	ll_id_ubicacion = il_id_ubicacion
	//Al hacer el insert se resetean todas las variables
	dw_detalle_bultos.insertrow(1)
	
	if ib_ubicacion_con_bulto_asociado then
		il_id_bulto = ll_almubimapa_codbar_id_alm_bultos
		ii_bultos   = 1
	else
		il_id_bulto  = 0
	end if	
	
	is_almacen      = ls_almacen
	is_zona         = ls_zona
	ii_fila         = li_fila
	ii_altura       = li_altura
	il_id_ubicacion = ll_id_ubicacion	
	
	dw_detalle_bultos.object.almubimapa_codbar_id[1] = il_id_ubicacion
	dw_detalle_bultos.object.almubimapa_codbar_almacen[1] = is_almacen
	dw_detalle_bultos.object.almubimapa_codbar_zona[1] = is_zona
	dw_detalle_bultos.object.almubimapa_codbar_fila[1] = ii_fila
	dw_detalle_bultos.object.almubimapa_codbar_altura[1] = ii_altura
	dw_detalle_bultos.object.almubimapa_codbar_color_fondo[1] = ll_color_fondo
	dw_detalle_bultos.object.almubimapa_codbar_color_texto[1] = ll_color_texto 
	
	dw_detalle_bultos.object.alm_bultos_id[1] = il_id_bulto
	dw_detalle_bultos.object.alm_bultos_lineas_id[1] = 0
	dw_detalle_bultos.object.alm_bultos_lineas_articulo[1] = ""
	dw_detalle_bultos.object.articulos_descripcion[1] = ""
	dw_detalle_bultos.object.alm_bultos_lineas_caja[1] = ""
	dw_detalle_bultos.object.alm_bultos_tipo_pallet[1] = "00000" //Las ubicaciones con bulto asociado siempre usan este tipo de pallet
	dw_detalle_bultos.object.alm_bultos_lineas_calidad[1] = ""
	dw_detalle_bultos.object.alm_bultos_lineas_tono[1] = ""
	dw_detalle_bultos.object.alm_bultos_lineas_calibre[1] = 0
	dw_detalle_bultos.object.alm_bultos_lineas_cantidad[1] = 0
		
	dw_detalle_bultos.object.alm_bultos_anyo_orden_carga[1] = 0
	dw_detalle_bultos.object.alm_bultos_codigo_orden_carga[1] = ""
	dw_detalle_bultos.object.alm_bultos_lineas_linea_orden_carga[1] = 0
	
	dw_detalle_bultos.sort()
	dw_detalle_bultos.groupcalc()
	
	ii_indice_lineas_bulto = 1
	f_setrow(1)
	il_id_bulto     = dw_detalle_bultos.object.alm_bultos_id[1]
	ii_lineas_bulto = 0	
	
end if

this.st_descripcion.text = is_almacen+'-'+is_zona+'-'+string(ii_fila,"##0")+"-"+string(ii_altura,"##0")+' '+string(il_id_bulto,"0000000000")

if il_id_ubicacion > 0 then
	
	if il_id_ubicacion_sugerida > 0 then
		update almubimapa_codbar 
		set    almubimapa_codbar.sugerida = 'N' 
		where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida
		and    almubimapa_codbar.sugerida = 'S';
		
		il_id_ubicacion_sugerida = il_id_ubicacion
		
		update almubimapa_codbar 
		set    almubimapa_codbar.sugerida = 'S' 
		where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida;
		
		commit;
	end if	
	
	if ls_activo = 'S' then
		if not(ii_bultos = 1 and ii_lineas_bulto > 1 and ib_obligatorio_marcar_una_linea) then
			this.event ue_siguiente_objeto()
		else
			if ii_bultos = 1 and ii_lineas_bulto > 1 then
				this.event ue_pre_siguiente_objeto()
			end if		
		end if				
	else
		messagebox("¡Atención!","La ubicación no está activa",StopSign!)
		event getfocus()	
	end if
end if
end subroutine

public subroutine f_leer_bulto ();string ls_ean13,ls_activo,ls_gestionar_en_piezas,ls_permitir_reservas
long   ll_id_ubicacion,ll_color_fondo,ll_color_texto,ll_almubimapa_codbar_id_alm_bultos

ls_ean13 = this.sle_codbar.text

f_inicializar_variables_instancia()

select isnull(alm_bultos.id,0), 
		 isnull(alm_bultos.id_ubicacion,0) 
into   :il_id_bulto, 
		 :ll_id_ubicacion 
from   alm_bultos 
where  alm_bultos.empresa = :codigo_empresa 
and    alm_bultos.ean13   = :ls_ean13;

select isnull(almubimapa_codbar.almacen,''),
		 isnull(almubimapa_codbar.zona,''),
		 isnull(almubimapa_codbar.fila,''),
		 isnull(almubimapa_codbar.altura,''),
		 isnull(almubimapa_codbar.id,0),
		 isnull(almubimapa_codbar.activo,''),
		 isnull(almubimapa_codbar.color_fondo,0),
		 isnull(almubimapa_codbar.color_texto,0), 
		 isnull(almubimapa_codbar.id_alm_bultos,0),
		 isnull(almubimapa_codbar.gestionar_en_piezas,''), 
		 isnull(almubimapa_codbar.permitir_reservas,'') 
into   :is_almacen,
		 :is_zona,
		 :ii_fila,
		 :ii_altura,
		 :il_id_ubicacion,
		 :ls_activo,
		 :ll_color_fondo, 
		 :ll_color_texto, 
		 :ll_almubimapa_codbar_id_alm_bultos, 
		 :ls_gestionar_en_piezas,
		 :ls_permitir_reservas 
from   almubimapa_codbar 
where  almubimapa_codbar.empresa = :codigo_empresa 
and    almubimapa_codbar.id      = :ll_id_ubicacion;

f_cargar_str_almubimapa_codbar(il_id_ubicacion,istr_almubimapa_codbar)
f_inicializar_str_almubimapa_codbar(istr_almubimapa_codbar)

if ll_almubimapa_codbar_id_alm_bultos > 0 then
	ib_ubicacion_con_bulto_asociado = true	
else
	ib_ubicacion_con_bulto_asociado = false
end if

if ls_gestionar_en_piezas = 'S' then
	ib_ubicacion_gestionada_en_piezas = true
else
	ib_ubicacion_gestionada_en_piezas = false
end if

if ls_permitir_reservas = 'N' then
	ib_ubicacion_permite_reservas = false
else
	ib_ubicacion_permite_reservas = true
end if

dw_detalle_bultos.setfilter("alm_bultos_id = "+string(il_id_bulto,"#########0"))
dw_detalle_bultos.filter()

ii_bultos = 1

ib_lanzar_modified = false
dw_detalle_bultos.retrieve(codigo_empresa,il_id_ubicacion)
ii_lineas_bulto = dw_detalle_bultos.rowcount()
ib_lanzar_modified = true

if ii_lineas_bulto > 0 then
	
	if ii_lineas_bulto > 1 and ib_obligatorio_marcar_una_linea then
		dw_detalle_bultos.modify("datawindow.footer.height = 156")
		st_lectura_caja_bulto.visible = true
		sle_codbar_caja_bulto.visible = true
		p_subir.visible   = true
		p_validar.visible = true
		p_bajar.visible   = true
		
		st_lectura_ubicacion.visible  = false
		sle_codbar_ubicacion.visible  = false			
		sle_codbar_ubicacion.text     = ""				
		
		sle_codbar_caja_bulto.setfocus()
	else
		dw_detalle_bultos.modify("datawindow.footer.height = 0")
		st_lectura_caja_bulto.visible = false
		sle_codbar_caja_bulto.visible = false
		sle_codbar_caja_bulto.text    = ""
		p_subir.visible   = false
		p_validar.visible = false
		p_bajar.visible   = false

		st_lectura_ubicacion.visible  = false
		sle_codbar_ubicacion.visible  = false			
		sle_codbar_ubicacion.text     = ""				
				
		ii_indice_lineas_bulto = 1
		il_id_bulto     = dw_detalle_bultos.object.alm_bultos_id[1]	
		il_alm_bultos_lineas_id = dw_detalle_bultos.object.alm_bultos_lineas_id[1]
		f_setrow(1)
	end if
else
	if il_id_ubicacion = 0 and ib_pedir_ubicacion_si_el_bulto_no_la_tiene then		
		dw_detalle_bultos.modify("datawindow.footer.height = 156")
		st_lectura_caja_bulto.visible = false
		sle_codbar_caja_bulto.visible = false
		sle_codbar_caja_bulto.text    = ""
		p_subir.visible   = false
		p_validar.visible = false
		p_bajar.visible   = false

		st_lectura_ubicacion.visible  = true
		sle_codbar_ubicacion.visible  = true
		
		sle_codbar_ubicacion.setfocus()
	else
		dw_detalle_bultos.modify("datawindow.footer.height = 0")
		st_lectura_caja_bulto.visible = false
		sle_codbar_caja_bulto.visible = false
		sle_codbar_caja_bulto.text    = ""
		p_subir.visible   = false
		p_validar.visible = false
		p_bajar.visible   = false				
								
		st_lectura_ubicacion.visible  = false
		sle_codbar_ubicacion.visible  = false			
		sle_codbar_ubicacion.text     = ""		
		if il_id_ubicacion <> 0 then
			//No hay lineas pero si tiene ubicacion el bulto
			f_cambia_ubicacion_bulto()
			f_setrow(1)
		end if
	end if
end if

this.st_descripcion.text = is_almacen+'-'+is_zona+'-'+string(ii_fila,"##0")+"-"+string(ii_altura,"##0")+' '+string(il_id_bulto,"0000000000")

if il_id_ubicacion_sugerida > 0 and il_id_ubicacion > 0 then
	update almubimapa_codbar 
	set    almubimapa_codbar.sugerida = 'N' 
	where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida
	and    almubimapa_codbar.sugerida = 'S';
	
	il_id_ubicacion_sugerida = il_id_ubicacion
	
	update almubimapa_codbar 
	set    almubimapa_codbar.sugerida = 'S' 
	where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida;
	
	commit;
end if	

if il_id_bulto > 0 and (not(ib_obligatorio_marcar_una_linea) or ii_lineas_bulto = 1) then
	if il_id_ubicacion = 0 and ib_pedir_ubicacion_si_el_bulto_no_la_tiene then
		this.event ue_pre_siguiente_objeto()
	else
		this.event ue_siguiente_objeto()
	end if
else
	if ii_bultos = 1 and ii_lineas_bulto > 1 then
		this.event ue_pre_siguiente_objeto()
	end if
end if
end subroutine

public subroutine f_leer_ean128 ();string ls_codigo_articulo,ls_descripcion_articulo
string ls_ean128,ls_ean13

ls_ean128 = this.sle_codbar.text

f_inicializar_variables_instancia()

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta
string ls_campo_busco

//Ean13
ls_campo_busco = "(01)"

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :is_codigo_articulo, 
			 :is_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(is_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :is_codigo_articulo, 
				 :is_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	f_cargar_str_articulos(codigo_empresa,is_codigo_articulo,istr_articulos)
	
	//Calidad
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ii_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
	
	f_cargar_str_almartcajas(codigo_empresa,is_codigo_articulo,is_codigo_caja,istr_almartcajas)
	
	f_cargar_str_palarticulo(codigo_empresa,is_codigo_articulo,is_codigo_pallet,is_codigo_caja,istr_palarticulo)
	
	dw_detalle_bultos.retrieve(codigo_empresa,is_codigo_articulo,is_codigo_calidad,is_lote,ii_calibre,is_codigo_pallet,is_codigo_caja)
	
	this.st_descripcion.text = '['+is_codigo_articulo+'] '+is_descripcion_articulo+' CL='+is_codigo_calidad+' LOTE='+is_lote+' C='+string(ii_calibre)+' CJ='+is_codigo_caja+' PLT='+is_codigo_pallet
else
	st_descripcion.text = sle_codbar.text
	dw_detalle_bultos.reset()
end if

//Chequeo articulo y lote
integer li_existe_articulo_lote
if is_codigo_articulo <> "" and is_lote <> "1" and istr_articulos.tono = 'S' then
	select isnull(sum(resultado.existe),0)
	into   :li_existe_articulo_lote
	from (select 1 as existe
			from  prodpartes_ot 
			where prodpartes_ot.articulo = :is_codigo_articulo
			and   prodpartes_ot.lote     = :is_lote
			union 
			select 1 as existe
			from  planificacion 
			where planificacion.cod_articulo = :is_codigo_articulo
			and   planificacion.lote         = :is_lote) as resultado;
else
	li_existe_articulo_lote = 1
end if
//

if is_codigo_articulo <> "" then
	if li_existe_articulo_lote = 0 and istr_articulos.tono = 'S' then
		f_grabar_incidencia("LECTURA EAN128","LOTE ERRONEO "+this.sle_codbar.text)
		messagebox("¡Error!","No existe el lote para el articulo seleccionado")
		//f_reset()
		this.event ue_siguiente_objeto()
	else
		this.event ue_siguiente_objeto()
	end if
else
	f_reset()
end if

/* Ejemplo un poco raro
program GS1;
 
{$APPTYPE CONSOLE}
 
uses
  Windows, SysUtils, Classes;  
 
type
  TRegTipo = (rtTexto, rtNumero, rtFecha, rtEAN13);
 
  TRegUnidades = (ruNinguna, ruKg, ruMetros, ruMetros2, ruMetros3, ruLitros,
    ruLibras, ruPulgadas, ruPulgadas2, ruPulgadas3, ruPies, ruPies2, ruPies3,
    ruYardas, ruYardas2, ruYardas3, ruOnzas, ruQuarts, ruGalones);
 
  TRegistro = record
    AI: String;
    Tipo: TRegTipo;
    Valor: String;
    Decimales: Integer;
    Unidades: TRegUnidades;
    Descripcion: String;
  end;
 
function LeerRegistro(var Codigo: String): TRegistro;
var
  C: Char;
begin
  if Copy(Codigo,1,2) = '00' then
    with Result do
    begin
      AI:= '00';
      Valor:= Copy(Codigo,3,18);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Shipping Container';
      Delete(Codigo,1,20);
    end else
  if Copy(Codigo,1,2) = '01' then
    with Result do
    begin
      AI:= '01';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Shipping Container Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '02' then
    with Result do
    begin
      AI:= '02';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of containers';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '10' then
    with Result do
    begin
      AI:= '10';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Batch Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '11' then
    with Result do
    begin
      AI:= '11';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Production Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '13' then
    with Result do
    begin
      AI:= '13';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Packaging Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '15' then
    with Result do
    begin
      AI:= '15';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Sell by Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '17' then
    with Result do
    begin
      AI:= '17';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Expiration Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '20' then
    with Result do
    begin
      AI:= '20';
      Valor:= Copy(Codigo,3,2);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Product Variant';
      Delete(Codigo,1,4);
    end else
  if Copy(Codigo,1,2) = '21' then
    with Result do
    begin
      AI:= '21';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,3) = '310' then
    with Result do
    begin
      AI:= '310';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '311' then
    with Result do
    begin
      AI:= '311';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '312' then
    with Result do
    begin
      AI:= '312';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '313' then
    with Result do
    begin
      AI:= '313';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '314' then
    with Result do
    begin
      AI:= '314';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '315' then
    with Result do
    begin
      AI:= '315';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '316' then
    with Result do
    begin
      AI:= '316';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '320' then
    with Result do
    begin
      AI:= '320';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '321' then
    with Result do
    begin
      AI:= '321';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '322' then
    with Result do
    begin
      AI:= '322';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '323' then
    with Result do
    begin
      AI:= '323';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '324' then
    with Result do
    begin
      AI:= '324';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '325' then
    with Result do
    begin
      AI:= '325';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '326' then
    with Result do
    begin
      AI:= '326';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '327' then
    with Result do
    begin
      AI:= '327';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '328' then
    with Result do
    begin
      AI:= '328';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '329' then
    with Result do
    begin
      AI:= '329';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '330' then
    with Result do
    begin
      AI:= '330';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '331' then
    with Result do
    begin
      AI:= '331';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '332' then
    with Result do
    begin
      AI:= '332';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '333' then
    with Result do
    begin
      AI:= '333';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '334' then
    with Result do
    begin
      AI:= '334';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '335' then
    with Result do
    begin
      AI:= '335';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '336' then
    with Result do
    begin
      AI:= '336';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '340' then
    with Result do
    begin
      AI:= '340';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '341' then
    with Result do
    begin
      AI:= '341';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '342' then
    with Result do
    begin
      AI:= '342';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '344' then
    with Result do
    begin
      AI:= '344';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Width/Diamater/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '345' then
    with Result do
    begin
      AI:= '345';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '346' then
    with Result do
    begin
      AI:= '346';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '347' then
    with Result do
    begin
      AI:= '347';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '348' then
    with Result do
    begin
      AI:= '348';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '349' then
    with Result do
    begin
      AI:= '349';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '350' then
    with Result do
    begin
      AI:= '350';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '351' then
    with Result do
    begin
      AI:= '351';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '352' then
    with Result do
    begin
      AI:= '352';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '353' then
    with Result do
    begin
      AI:= '353';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '354' then
    with Result do
    begin
      AI:= '354';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '355' then
    with Result do
    begin
      AI:= '355';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '356' then
    with Result do
    begin
      AI:= '356';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruOnzas;
      Descripcion:= 'Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '360' then
    with Result do
    begin
      AI:= '360';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '361' then
    with Result do
    begin
      AI:= '361';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '362' then
    with Result do
    begin
      AI:= '362';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '363' then
    with Result do
    begin
      AI:= '363';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '364' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '365' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '366' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '367' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '368' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '369' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,2) = '37' then
    with Result do
    begin
      AI:= '37';
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of Units Contained';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '400' then
    with Result do
    begin
      AI:= '400';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Customer Purchase Order Number';
      Delete(Codigo,1,3);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '410' then
    with Result do
    begin
      AI:= '410';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Ship To/Deliver To Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '411' then
    with Result do
    begin
      AI:= '411';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Bill To/Invoice Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '412' then
    with Result do
    begin
      AI:= '412';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Purchase From Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '8001' then
    with Result do
    begin
      AI:= '8001';
      Valor:= Copy(Codigo,5,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Roll Products - Width/Length/Core Diameter';
      Delete(Codigo,1,18);
    end else
  if Copy(Codigo,1,2) = '8004' then
    with Result do
    begin
      AI:= '8004';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'UPC/EAN Serial Identification';
      Delete(Codigo,1,4);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '8005' then
    with Result do
    begin
      AI:= '8005';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Price per Unit of Measure';
      Delete(Codigo,1,10);
    end else
      raise Exception.Create('AI desconocido');
end;
 
function UnidToStr(Unidad: TRegUnidades): String;
begin
  case Unidad of
    ruNinguna: Result:= EmptyStr;
    ruKg: Result:= 'Kilogramos';
    ruMetros: Result:= 'Metros';
    ruMetros2: Result:= 'Metros cuadrados';
    ruMetros3: Result:= 'Metros cubicos';
    ruLitros: Result:= 'Litros';
    ruLibras: Result:= 'Libras';
    ruPulgadas: Result:= 'Pulgadas';
    ruPulgadas2: Result:= 'Pulgadas cuadradas';
    ruPulgadas3: Result:= 'Pulgadas cubicas';
    ruPies: Result:= 'Pies';
    ruPies2: Result:= 'Pies cuadrados';
    ruPies3: Result:= 'Pies cubicos';
    ruYardas: Result:= 'Yardas';
    ruYardas2: Result:= 'Yardas cuadradas';
    ruYardas3: Result:= 'Yardas cubicas';
    ruOnzas: Result:= 'Onzas';
    ruQuarts: Result:= 'Quarts';
    ruGalones: Result:= 'Galones';
  end;
end;
 
 
var
  Str: String;
  i: Integer;
  d: Double;
  Registro: TRegistro;
begin
  while TRUE do
  try
    Readln(Str);
    while Str <> EmptyStr do
    begin
      Writeln;
      Registro:= LeerRegistro(Str);
      Writeln('AI: ' + Registro.AI);
      Writeln('Descr: ' + Registro.Descripcion);
      Writeln('Valor: ' + Registro.Valor);
      case Registro.Tipo of
        rtTexto:  Writeln('Tipo: Texto');
        rtNumero:
          begin
            Writeln('Tipo: Numero');
            Writeln('Decimales: ' + IntToStr(Registro.Decimales));
            Writeln('Unidades: ' + UnidToStr(Registro.Unidades));
            d:= StrToFloat(Registro.Valor);
            i:= Registro.Decimales;
            while i>0 do
            begin
              d:= d / 10;
              dec(i);
            end;
            Writeln('Valor: ' + FloatToStr(d));
          end;
        rtFecha:
          begin
            Writeln('Tipo: Fecha');
            with Registro do
              Writeln('Fecha: ' + Copy(Valor,5,2) + '/' + Copy(Valor,3,2)
                + '/' + Copy(Valor,1,2));
          end;
        rtEAN13:  Writeln('Tipo: EAN13');
      end;
    end;
    Writeln;
  except
    On E: Exception do
    begin
      Writeln;
      Writeln('Error al leer codigo');
      Writeln;
    end;
  end;
end.
*/
end subroutine

public subroutine f_leer_articulo ();string ls_codigo_articulo,ls_descripcion_articulo
string ls_ean13

ls_ean13 = this.sle_codbar.text

f_inicializar_variables_instancia()

select isnull(articulos.codigo,""), 
		 isnull(articulos.descripcion,"") 
into   :is_codigo_articulo, 
		 :is_descripcion_articulo 
from   articulos 
where  articulos.empresa = :codigo_empresa 
and    articulos.ean13_sga = :ls_ean13;

if trim(is_codigo_articulo) = "" then
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :is_codigo_articulo, 
			 :is_descripcion_articulo 
	from   articulos 
	where  articulos.empresa = :codigo_empresa 
	and    articulos.ean13   = :ls_ean13;
end if
	
this.st_descripcion.text = '['+is_codigo_articulo+'] '+is_descripcion_articulo

if trim(is_codigo_articulo) <> "" then
	this.event ue_siguiente_objeto()
end if
end subroutine

public subroutine f_inicializar_variables_instancia ();str_almubimapa_codbar lstr_almubimapa_codbar

f_inicializar_str_almubimapa_codbar(lstr_almubimapa_codbar)
//Ubicacion
il_id_ubicacion = 0
is_almacen = ""
is_zona = ""
ii_fila = 0
ii_altura = 0
ii_bultos = 0
ii_lineas_bulto = 0
ii_indice_lineas_bulto = 0
ib_ubicacion_con_bulto_asociado = false
ib_ubicacion_gestionada_en_piezas = false
ib_ubicacion_permite_reservas = true

istr_almubimapa_codbar = lstr_almubimapa_codbar
//Bulto
il_id_bulto = 0
il_alm_bultos_lineas_id = 0
il_piezas = 0
il_linea_orden_carga = 0
is_codigo_articulo = ""
is_codigo_caja = ""
is_codigo_pallet = ""
is_codigo_calidad = ""
is_lote = ""
is_orden_carga = ""
ii_calibre = 0
ii_anyo_orden_carga = 0
ib_bulto_asociado_a_orden_de_carga = false
//Articulo
is_descripcion_articulo = ""
istr_articulos   = istr_articulos_vacio
istr_almartcajas = istr_almartcajas_vacio
istr_palarticulo = istr_palarticulo_vacio
end subroutine

public function long f_setrow (long row);long ll_resultado

//if row > dw_detalle_bultos.rowcount() then
//	ll_resultado = 0
//else
	if dw_detalle_bultos.setrow(row) = 1 then
		dw_detalle_bultos.event rowfocuschanged(row)
		ll_resultado = row
		/*
		//Ubicacion
		il_id_ubicacion = 0
		is_almacen = ""
		is_zona = ""
		ii_fila = 0
		ii_altura = 0
		ii_bultos = 0
		ii_lineas_bulto = 0	
		ii_indice_lineas_bulto = row
		//Bulto
		il_id_bulto = 0
		il_piezas               = dw_detalle_bultos.object.[row]
		il_linea_orden_carga    = dw_detalle_bultos.object.[row]
		is_codigo_articulo      = dw_detalle_bultos.object.[row]
		is_codigo_caja          = dw_detalle_bultos.object.[row]
		is_codigo_pallet        = dw_detalle_bultos.object.[row]
		is_codigo_calidad       = dw_detalle_bultos.object.[row]
		is_lote                 = dw_detalle_bultos.object.[row]
		is_orden_carga          = dw_detalle_bultos.object.[row]
		ii_calibre              = dw_detalle_bultos.object.[row]
		ii_anyo_orden_carga     = dw_detalle_bultos.object.[row]
		//Articulo
		is_descripcion_articulo = dw_detalle_bultos.object.[row]
		*/
	else
		ll_resultado = 0
	end if
//end if

return ll_resultado
end function

public function integer f_reset ();f_inicializar_variables_instancia()
dw_detalle_bultos.reset()
dw_detalle_bultos.modify("datawindow.footer.height = 0")
st_lectura_caja_bulto.visible = false
sle_codbar_caja_bulto.visible = false
p_subir.visible   = false
p_validar.visible = false
p_bajar.visible   = false
sle_codbar_caja_bulto.text    = ""
sle_codbar.text               = ""
st_descripcion.text           = ""

return 1
end function

public function integer f_sugerir_ubicacion_destino (u_sle_codbar arg_u_sle_codbar_a_ubicar);long ll_color_fondo,ll_color_texto 
datastore datos
string consulta, ls_orden,  ls_orden2
long ll_piezas_bulto_a_ubicar, ll_piezas_pallet_articulo
boolean lb_pico
string filtro
string ll_tipo_palet
string ls_tipo_ubicacion_preparado = '8'

iu_sle_codbar_ubicacion_sugiero = arg_u_sle_codbar_a_ubicar

if il_id_ubicacion_sugerida > 0 then
	update almubimapa_codbar 
	set    almubimapa_codbar.sugerida = 'N' 
	where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida
	and    almubimapa_codbar.sugerida = 'S';
	
	commit;
end if

il_id_ubicacion_sugerida  = 0
is_almacen_sugerida       = ""
is_zona_sugerida          = ""
ii_fila_sugerida          = 0
ii_fila_sugerida          = 0
ll_piezas_bulto_a_ubicar  = arg_u_sle_codbar_a_ubicar.il_piezas 
ll_piezas_pallet_articulo = arg_u_sle_codbar_a_ubicar.istr_almartcajas.piezascaja * arg_u_sle_codbar_a_ubicar.istr_palarticulo.cajaspallet
ll_tipo_palet             = arg_u_sle_codbar_a_ubicar.istr_palarticulo.codigo

if ll_piezas_bulto_a_ubicar < ll_piezas_pallet_articulo then
	lb_pico = true 
else 
	lb_pico = false
end if

string ls_tipo_ubicacion_auxiliar

SELECT isnull(tipo_ubicacion.tipo_ubicacion_codigo_aux,'')
INTO   :ls_tipo_ubicacion_auxiliar
FROM   tipo_ubicacion
WHERE  tipo_ubicacion.empresa = :codigo_empresa
AND    tipo_ubicacion.codigo  = :arg_u_sle_codbar_a_ubicar.istr_articulos.tipo_ubicacion;

dec ld_ultima_distancia_tipo_ubi_articulo

select isnull(max(distancia),0)
into   :ld_ultima_distancia_tipo_ubi_articulo
from   almubimapa_codbar
where  almubimapa_codbar.empresa        = :codigo_empresa
and    almubimapa_codbar.tipo_ubicacion = :arg_u_sle_codbar_a_ubicar.istr_articulos.tipo_ubicacion;

if arg_u_sle_codbar_a_ubicar.ib_bulto_asociado_a_orden_de_carga then
	//Bulto con orden de carga asociada
	if ii_lineas_bulto > 1 or lb_pico then
		//Buscamos ubicacion en la zona de preparados
		filtro    = " and almubimapa_codbar.tipo_ubicacion = '"+ls_tipo_ubicacion_preparado+"' " 
		ls_orden  = "1"
		ls_orden2 = " almubimapa_codbar.altura ASC "
	else
		//Buscamos si la orden ya tiene algo ubicado y si no es asi buscamos un muelle de carga vacio
		filtro    = " and almubimapa_codbar.tipo_ubicacion = '"+ls_tipo_ubicacion_preparado+"' "
		ls_orden  = "1"
		ls_orden2 = " almubimapa_codbar.altura ASC "		
	end if
	
	//Vamos a buscar si la oc ya tiene algún muelle asignado
	
	consulta =  "	SELECT isnull(almubimapa_codbar.id,0) as ubicacion, "+&
					"			 isnull(almubimapa_codbar.almacen, '') as almacen, "+&
					"			 isnull(almubimapa_codbar.zona, '') as zona, "+&
					"			 isnull(almubimapa_codbar.fila, 0) as fila, "+&
					"			 isnull(almubimapa_codbar.altura, 0) as altura , "+&
					"			 isnull(almubimapa_codbar.color_fondo, 0) as color_fondo , "+&
					"			 isnull(almubimapa_codbar.color_texto, 0) as  color_texto "+&
					"	FROM  almubimapa_codbar "+&
					"	WHERE almubimapa_codbar.empresa = '"+codigo_empresa+"'  "+&
					filtro +&
					"	AND      EXISTS ( SELECT alm_bultos.id_ubicacion  "+&
					"							FROM   alm_bultos,  "+&
					"									 alm_bultos_lineas, "+&
					"                           venliped, "+&
					"                           venliped_reservas "+&
					"							WHERE  alm_bultos.id             = alm_bultos_lineas.id_alm_bultos "+&
					"							AND    alm_bultos.id_ubicacion   = almubimapa_codbar.id "+&
					"                    AND    alm_bultos_lineas.id      = venliped_reservas.alm_bultos_lineas_id "+&
					"                    AND    venliped_reservas.empresa = venliped.empresa "+&
					"                    AND    venliped_reservas.anyo    = venliped.anyo "+&
					"                    AND    venliped_reservas.pedido  = venliped.pedido "+&
					"                    AND    venliped_reservas.linea   = venliped.linea "+&
					"                    AND    venliped.id_alm_orden_carga = "+string(arg_u_sle_codbar_a_ubicar.il_id_alm_orden_carga_bulto)+" "+&
					"                    AND    venliped_reservas.preparado = 'S' ) "+&
					"	ORDER BY " +ls_orden+ " , almubimapa_codbar.distancia , " +ls_orden2+ ""	
	
	
	f_cargar_cursor_transaccion(sqlca,datos,consulta)
	
	if datos.rowcount() > 0 then
	
		il_id_ubicacion_sugerida 	= datos.object.ubicacion[1]
		is_almacen_sugerida		   = datos.object.almacen[1]
		is_zona_sugerida				= datos.object.zona[1]
		ii_fila_sugerida				= datos.object.fila[1]
		ii_altura_sugerida			= datos.object.altura[1]
		ll_color_fondo					= datos.object.color_fondo[1]
		ll_color_texto					= datos.object.color_texto[1]
		
		destroy datos
		
		if il_id_ubicacion_sugerida = 0 then
			st_texto.backcolor = ll_color_fondo_texto
			st_texto.textcolor = ll_color_texto_texto
			st_texto.text = is_descripcion
			ib_sugiriendo_ubicacion = false
			return -1
		else	
			st_texto.backcolor = ll_color_fondo
			st_texto.textcolor = ll_color_texto	
			st_texto.text = is_almacen_sugerida+'-'+is_zona_sugerida+'-'+string(ii_fila_sugerida,'##0')+'-'+string(ii_altura_sugerida,'#0')
			ib_sugiriendo_ubicacion = true
			
			if il_id_ubicacion_sugerida > 0 then
//				update almubimapa_codbar 
//				set    almubimapa_codbar.sugerida = 'S' 
//				where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida;
//				
//				commit;
			end if			
			
			return 1
		end if
	
	else
		destroy datos
		//Ubicacion libre
		if trim(ls_tipo_ubicacion_preparado) <> '' then
			if ii_lineas_bulto > 1 or lb_pico then
				//Buscamos ubicacion en la zona de preparados
				filtro    = " and almubimapa_codbar.tipo_ubicacion = '"+ls_tipo_ubicacion_preparado+"' and almubimapa_codbar.apilado_en_bloque = 'N' " 
				ls_orden  = "1"
				ls_orden2 = " almubimapa_codbar.altura ASC "
			else
				//Buscamos si la orden ya tiene algo ubicado y si no es asi buscamos un muelle de carga vacio
				filtro    = " and almubimapa_codbar.tipo_ubicacion = '"+ls_tipo_ubicacion_preparado+"' and almubimapa_codbar.apilado_en_bloque = 'S' "
				ls_orden  = "1"
				ls_orden2 = " almubimapa_codbar.altura ASC "		
			end if
			
			if is_filto_ubicaciones_sugeridas_descartadas <> "" then
				filtro += " and almubimapa_codbar.id not in("+is_filto_ubicaciones_sugeridas_descartadas+") "
			end if 
			
			consulta =  "	SELECT isnull(almubimapa_codbar.id,0) as ubicacion, "+&
							"			 isnull(almubimapa_codbar.almacen, '') as almacen, "+&
							"			 isnull(almubimapa_codbar.zona, '') as zona, "+&
							"			 isnull(almubimapa_codbar.fila, 0) as fila, "+&
							"			 isnull(almubimapa_codbar.altura, 0) as altura , "+&
							"			 isnull(almubimapa_codbar.color_fondo, 0) as color_fondo , "+&
							"			 isnull(almubimapa_codbar.color_texto, 0) as  color_texto "+&
							"	FROM  almubimapa_codbar "+&
							"	WHERE almubimapa_codbar.empresa = '"+codigo_empresa+"'  "+&
							"	AND   almubimapa_codbar.activo  = 'S'  "+&
							"	AND   len(almubimapa_codbar.zona) > 1  "+filtro+&
							"  AND   isnull(almubimapa_codbar.sugerida,'') <> 'S' "+&
							"	AND  NOT EXISTS ( SELECT alm_bultos.id_ubicacion  "+&
							"							FROM   alm_bultos,  "+&
							"									 alm_bultos_lineas  "+&
							"							WHERE  alm_bultos.id           = alm_bultos_lineas.id_alm_bultos "+&
							"							AND    alm_bultos.id_ubicacion = almubimapa_codbar.id ) "+&
							"	ORDER BY " +ls_orden+ " , almubimapa_codbar.distancia , " +ls_orden2+ " "	
							
			f_cargar_cursor_transaccion(sqlca,datos,consulta)
			
			if datos.rowcount() > 0 then
			
				il_id_ubicacion_sugerida 	= datos.object.ubicacion[1]
				is_almacen_sugerida		   = datos.object.almacen[1]
				is_zona_sugerida				= datos.object.zona[1]
				ii_fila_sugerida				= datos.object.fila[1]
				ii_altura_sugerida			= datos.object.altura[1]
				ll_color_fondo					= datos.object.color_fondo[1]
				ll_color_texto					= datos.object.color_texto[1]
				
				destroy datos
				
				if il_id_ubicacion_sugerida = 0 then
					st_texto.backcolor = ll_color_fondo_texto
					st_texto.textcolor = ll_color_texto_texto
					st_texto.text = is_descripcion
					ib_sugiriendo_ubicacion = false
					return -1
				else	
					st_texto.backcolor = ll_color_fondo
					st_texto.textcolor = ll_color_texto	
					st_texto.text = is_almacen_sugerida+'-'+is_zona_sugerida+'-'+string(ii_fila_sugerida,'##0')+'-'+string(ii_altura_sugerida,'#0')
					ib_sugiriendo_ubicacion = true
					
					if il_id_ubicacion_sugerida > 0 then
						update almubimapa_codbar 
						set    almubimapa_codbar.sugerida = 'S' 
						where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida;
						
						commit;
					end if					
					
					return 1
				end if
			else
				destroy datos
				
				il_id_ubicacion_sugerida 	= 0
				is_almacen_sugerida		   = ''
				is_zona_sugerida				= ''
				ii_fila_sugerida				= 0
				ii_altura_sugerida			= 0
				ll_color_fondo					= rgb(255,0,0)
				ll_color_texto					= rgb(255,255,255)
				
				st_texto.backcolor = ll_color_fondo_texto
				st_texto.textcolor = ll_color_texto_texto
				st_texto.text      = 'COMPLETO'
				ib_sugiriendo_ubicacion = true
				return 1	//-1
			end if
		end if
	end if
			
else
	//Bulto sin orden de carga asociada
	
	filtro = " and almubimapa_codbar.tipo_ubicacion = '"+arg_u_sle_codbar_a_ubicar.istr_articulos.tipo_ubicacion+"' " 
	
	if is_filto_ubicaciones_sugeridas_descartadas <> "" then
		filtro += " and almubimapa_codbar.id not in("+is_filto_ubicaciones_sugeridas_descartadas+") "
	end if 
	
	if lb_pico then
		filtro += " and almubimapa_codbar.altura = 1 " 
	else
		filtro += " and almubimapa_codbar.altura <> 1 " 
	end if
	
	// Ubicamos según tipo de ubicación ABC
	choose case arg_u_sle_codbar_a_ubicar.istr_articulos.tipo_abc
		case "A+"
			ls_orden =  " case almubimapa_codbar.clasificacion_abc "+&
							" when 'A+' then 1  "+&
							" when 'A'  then 2  "+&
							" when 'B'  then 3  "+&
							" when 'C'  then 4  "+&
							" else 	        5  end "
		case "A"
			ls_orden =  " case almubimapa_codbar.clasificacion_abc "+&
							" when 'A'  then 1  "+&
							" when 'A+' then 2  "+&
							" when 'B'  then 3  "+&
							" when 'C'  then 4  "+&
							" else 	        5  end "			

		case "B"
			ls_orden =  " case almubimapa_codbar.clasificacion_abc "+&
							" when 'B'  then 1  "+&
							" when 'A'  then 2  "+&
							" when 'C'  then 3  "+&
							" when 'A+' then 4  "+&
							" else 	        5  end "			
							
		case "C"
			ls_orden =  " case almubimapa_codbar.clasificacion_abc "+&
							" when 'C'  then 1  "+&
							" when 'B'  then 2  "+&
							" when 'A'  then 3  "+&
							" when 'A+' then 4  "+&
							" else 	        5  end "			

		case else 
			ls_orden = '1'
						
	end choose
	
	// Ubicamos según sea pallet completo o imcompleto
	choose case lb_pico
		case true
				ls_orden2 = " almubimapa_codbar.altura ASC "				
		case false
			ls_orden2 = " almubimapa_codbar.altura ASC "	
		case else 
			ls_orden2 = '1'
						
	end choose

	//Vamos a buscar una ubicacion libre
	
	consulta =  "	SELECT isnull(almubimapa_codbar.id,0) as ubicacion, "+&
					"			 isnull(almubimapa_codbar.almacen, '') as almacen, "+&
					"			 isnull(almubimapa_codbar.zona, '') as zona, "+&
					"			 isnull(almubimapa_codbar.fila, 0) as fila, "+&
					"			 isnull(almubimapa_codbar.altura, 0) as altura , "+&
					"			 isnull(almubimapa_codbar.color_fondo, 0) as color_fondo , "+&
					"			 isnull(almubimapa_codbar.color_texto, 0) as  color_texto "+&
					"	FROM  almubimapa_codbar "+&
					"	WHERE almubimapa_codbar.empresa = '"+codigo_empresa+"'  "+&
					"	AND   almubimapa_codbar.activo  = 'S'  "+&
					"	AND   len(almubimapa_codbar.zona) > 1  "+filtro+&
					"  AND   isnull(almubimapa_codbar.sugerida,'') <> 'S' "+&
					"	AND  NOT EXISTS ( SELECT alm_bultos.id_ubicacion  "+&
					"							FROM   alm_bultos,  "+&
					"									 alm_bultos_lineas  "+&
					"							WHERE  alm_bultos.id           = alm_bultos_lineas.id_alm_bultos "+&
					"							AND    alm_bultos.id_ubicacion = almubimapa_codbar.id ) "+&
					"	ORDER BY " +ls_orden+ " , almubimapa_codbar.distancia , " +ls_orden2+ ""	
	
	
	f_cargar_cursor_transaccion(sqlca,datos,consulta)
	
	if datos.rowcount() > 0 then
	
		il_id_ubicacion_sugerida 	= datos.object.ubicacion[1]
		is_almacen_sugerida		   = datos.object.almacen[1]
		is_zona_sugerida				= datos.object.zona[1]
		ii_fila_sugerida				= datos.object.fila[1]
		ii_altura_sugerida			= datos.object.altura[1]
		ll_color_fondo					= datos.object.color_fondo[1]
		ll_color_texto					= datos.object.color_texto[1]
		
		destroy datos
		
		if il_id_ubicacion_sugerida = 0 then
			st_texto.backcolor = ll_color_fondo_texto
			st_texto.textcolor = ll_color_texto_texto
			st_texto.text = is_descripcion
			ib_sugiriendo_ubicacion = false
			return -1
		else	
			st_texto.backcolor = ll_color_fondo
			st_texto.textcolor = ll_color_texto	
			st_texto.text = is_almacen_sugerida+'-'+is_zona_sugerida+'-'+string(ii_fila_sugerida,'##0')+'-'+string(ii_altura_sugerida,'#0')
			ib_sugiriendo_ubicacion = true
			
			if il_id_ubicacion_sugerida > 0 then
				update almubimapa_codbar 
				set    almubimapa_codbar.sugerida = 'S' 
				where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida;
				
				commit;
			end if			
			
			return 1
		end if
	
	else
		destroy datos
		//Tipo Ubicación auxiliar
		if trim(ls_tipo_ubicacion_auxiliar) <> '' then
			filtro = " and almubimapa_codbar.tipo_ubicacion = '"+ls_tipo_ubicacion_auxiliar+"' " 
			
			if is_filto_ubicaciones_sugeridas_descartadas <> "" then
				filtro += " and almubimapa_codbar.id not in("+is_filto_ubicaciones_sugeridas_descartadas+") "
			end if 
			
			if lb_pico then
				filtro += " and almubimapa_codbar.altura = 1 " 
			else
				filtro += " and almubimapa_codbar.altura <> 1 "
			end if		
			
			consulta =  "	SELECT isnull(almubimapa_codbar.id,0) as ubicacion, "+&
							"			 isnull(almubimapa_codbar.almacen, '') as almacen, "+&
							"			 isnull(almubimapa_codbar.zona, '') as zona, "+&
							"			 isnull(almubimapa_codbar.fila, 0) as fila, "+&
							"			 isnull(almubimapa_codbar.altura, 0) as altura , "+&
							"			 isnull(almubimapa_codbar.color_fondo, 0) as color_fondo , "+&
							"			 isnull(almubimapa_codbar.color_texto, 0) as  color_texto "+&
							"	FROM  almubimapa_codbar "+&
							"	WHERE almubimapa_codbar.empresa = '"+codigo_empresa+"'  "+&
							"	AND   almubimapa_codbar.activo  = 'S'  "+&
							"	AND   len(almubimapa_codbar.zona) > 1  "+filtro+&
							"  AND   isnull(almubimapa_codbar.sugerida,'') <> 'S' "+&
							"	AND  NOT EXISTS ( SELECT alm_bultos.id_ubicacion  "+&
							"							FROM   alm_bultos,  "+&
							"									 alm_bultos_lineas  "+&
							"							WHERE  alm_bultos.id           = alm_bultos_lineas.id_alm_bultos "+&
							"							AND    alm_bultos.id_ubicacion = almubimapa_codbar.id ) "+&
							"	ORDER BY " +ls_orden+ " , almubimapa_codbar.distancia , " +ls_orden2+ " "	
							
			f_cargar_cursor_transaccion(sqlca,datos,consulta)
			
			if datos.rowcount() > 0 then
			
				il_id_ubicacion_sugerida 	= datos.object.ubicacion[1]
				is_almacen_sugerida		   = datos.object.almacen[1]
				is_zona_sugerida				= datos.object.zona[1]
				ii_fila_sugerida				= datos.object.fila[1]
				ii_altura_sugerida			= datos.object.altura[1]
				ll_color_fondo					= datos.object.color_fondo[1]
				ll_color_texto					= datos.object.color_texto[1]
				
				destroy datos
				
				if il_id_ubicacion_sugerida = 0 then
					st_texto.backcolor = ll_color_fondo_texto
					st_texto.textcolor = ll_color_texto_texto
					st_texto.text = is_descripcion
					ib_sugiriendo_ubicacion = false
					return -1
				else	
					st_texto.backcolor = ll_color_fondo
					st_texto.textcolor = ll_color_texto	
					st_texto.text = is_almacen_sugerida+'-'+is_zona_sugerida+'-'+string(ii_fila_sugerida,'##0')+'-'+string(ii_altura_sugerida,'#0')
					ib_sugiriendo_ubicacion = true
					
					if il_id_ubicacion_sugerida > 0 then
						update almubimapa_codbar 
						set    almubimapa_codbar.sugerida = 'S' 
						where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida;
						
						commit;
					end if					
					
					return 1
				end if
			else
				destroy datos
				
				il_id_ubicacion_sugerida 	= 0
				is_almacen_sugerida		   = ''
				is_zona_sugerida				= ''
				ii_fila_sugerida				= 0
				ii_altura_sugerida			= 0
				ll_color_fondo					= rgb(255,0,0)
				ll_color_texto					= rgb(255,255,255)
				
				st_texto.backcolor = ll_color_fondo_texto
				st_texto.textcolor = ll_color_texto_texto
				st_texto.text      = 'COMPLETO'
				ib_sugiriendo_ubicacion = true
				return 1	//-1
			end if
		end if
	end if


end if


/*
long ll_color_fondo,ll_color_texto 
datastore datos
string consulta, ls_orden,  ls_orden2
long ll_piezas_bulto_a_ubicar, ll_piezas_pallet_articulo
boolean lb_pico
string filtro
string ll_tipo_palet

il_id_ubicacion_sugerida = 0
is_almacen_sugerida = ""
is_zona_sugerida    = ""
ii_fila_sugerida    = 0
ii_fila_sugerida  = 0
ll_piezas_bulto_a_ubicar = arg_u_sle_codbar_a_ubicar.il_piezas 
ll_piezas_pallet_articulo =   arg_u_sle_codbar_a_ubicar.istr_almartcajas.piezascaja * arg_u_sle_codbar_a_ubicar.istr_palarticulo.cajaspallet
ll_tipo_palet = arg_u_sle_codbar_a_ubicar.istr_palarticulo.codigo

// Para evitar que sugiera ubicaciones de contenedores
if arg_u_sle_codbar_a_ubicar.istr_articulos.uso = '3' or arg_u_sle_codbar_a_ubicar.istr_articulos.uso = '0' then
	filtro = " AND almubimapa_codbar.zona <> 'AA'  AND almubimapa_codbar.zona <> 'AL' AND almubimapa_codbar.zona <> 'BA' AND almubimapa_codbar.zona <> 'BL' "
else
	filtro = " AND almubimapa_codbar.zona in ( 'AA', 'AL', 'BA', 'BL')  "
end if	

if ll_piezas_bulto_a_ubicar < ll_piezas_pallet_articulo then
	lb_pico = true 
else 
	lb_pico = false
end if

// Ubicamos según tipo de ubicación ABC
choose case arg_u_sle_codbar_a_ubicar.istr_articulos.tipo_abc
	case "A+"
			ls_orden = " case almubimapa_codbar.clasificacion_abc "+&
					"		when 'A+' then 1  "+&
					"		when 'A' then 2  "+&
					"		when 'B' then 3  "+&
					"		when 'C' then 4   "+&
					"		else 	5  "+&				
					"		end "
	case "A"
			ls_orden = " case almubimapa_codbar.clasificacion_abc "+&
					"		when 'A' then 1  "+&
					"		when 'A+' then 2  "+&
					"		when 'B' then 3  "+&
					"		when 'C' then 4  "+&
					"		else 	5  "+&				
					"		end "
					
	case "B"
			ls_orden = " case almubimapa_codbar.clasificacion_abc "+&
					"		when 'B' then 1  "+&
					"		when 'A' then 2  "+&
					"		when 'C' then 3  "+&
					"		when 'A+' then 4  "+&
					"		else 	5  "+&				
					"		end "
					
	case "C"
			ls_orden = "  case almubimapa_codbar.clasificacion_abc "+&
					"		when 'C' then 1  "+&
					"		when 'B' then 2  "+&
					"		when 'A' then 3  "+&
					"		when 'A+' then 4  "+&
					"		else 	5  "+&				
					"		end "
	case else 
		ls_orden = '1'
					
end choose

// Ubicamos según sea pallet completo o imcompleto
choose case lb_pico
	case true
			ls_orden2 = "   almubimapa_codbar.altura ASC "
			
	case false
			ls_orden2 = " case almubimapa_codbar.altura "+&
					"		when '1' then 6  "+&
					"		when '2' then 5  "+&
					"		when '3' then 1  "+&
					"		when '4' then 2  "+&
					"		when '5' then 3  "+&
					"		when '6' then 4  "+&
					"		else 	1  "+&				
					"		end "
	case else 
		ls_orden2 = '1'
					
end choose

//Vamos a buscar una ubicacion libre

consulta = &
"	SELECT TOP 1 isnull(almubimapa_codbar.id,0) as ubicacion, "+&
"			 isnull(almubimapa_codbar.almacen, '') as almacen, "+&
"			 isnull(almubimapa_codbar.zona, '') as zona, "+&
"			 isnull(almubimapa_codbar.fila, 0) as fila, "+&
"			 isnull(almubimapa_codbar.altura, 0) as altura , "+&
"			 isnull(almubimapa_codbar.color_fondo, 0) as color_fondo , "+&
"			 isnull(almubimapa_codbar.color_texto, 0) as  color_texto "+&
"	FROM  almubimapa_codbar "+&
"	WHERE almubimapa_codbar.empresa = '"+codigo_empresa+"'  "+&
"	AND   almubimapa_codbar.activo  = 'S'  "+&
"	AND   len(almubimapa_codbar.zona) > 1  "+filtro+&
"	AND  NOT EXISTS ( SELECT alm_bultos.id_ubicacion  "+&
"							FROM   alm_bultos,  "+&
"									 alm_bultos_lineas  "+&
"							WHERE  alm_bultos.id           = alm_bultos_lineas.id_alm_bultos "+&
"							AND    alm_bultos.id_ubicacion = almubimapa_codbar.id ) "+&
"	ORDER BY " +ls_orden+ " , almubimapa_codbar.almacen, " +ls_orden2+ ", almubimapa_codbar.fila, almubimapa_codbar.zona "			 

//clipboard(consulta)
f_cargar_cursor_trans (SQLCA, consulta, datos)

if datos.rowcount() > 0 then

	il_id_ubicacion_sugerida 	= datos.object.ubicacion[1]
	is_almacen_sugerida		= datos.object.almacen[1]
	is_zona_sugerida				= datos.object.zona[1]
	ii_fila_sugerida				= datos.object.fila[1]
	ii_altura_sugerida			= datos.object.altura[1]
	ll_color_fondo					= datos.object.color_fondo[1]
	ll_color_texto					= datos.object.color_texto[1]
	
	if il_id_ubicacion_sugerida = 0 then
		st_texto.backcolor = ll_color_fondo_texto
		st_texto.textcolor = ll_color_texto_texto
		st_texto.text = is_descripcion
		return -1
	else	
		st_texto.backcolor = ll_color_fondo
		st_texto.textcolor = ll_color_texto	
		st_texto.text = is_almacen_sugerida+'-'+is_zona_sugerida+'-'+string(ii_fila_sugerida,'##0')+'-'+string(ii_altura_sugerida,'#0')
		return 1
	end if

end if

*/

end function

public subroutine f_leer_ean128_eng ();string ls_codigo_articulo,ls_descripcion_articulo
string ls_ean128,ls_ean13

ls_ean128 = this.sle_codbar.text

f_inicializar_variables_instancia()

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta
string ls_campo_busco

//Ean13
ls_campo_busco = ")01="

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :is_codigo_articulo, 
			 :is_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(is_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :is_codigo_articulo, 
				 :is_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	f_cargar_str_articulos(codigo_empresa,is_codigo_articulo,istr_articulos)
	
	//Calidad
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ii_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
	
	f_cargar_str_almartcajas(codigo_empresa,is_codigo_articulo,is_codigo_caja,istr_almartcajas)
	
	f_cargar_str_palarticulo(codigo_empresa,is_codigo_articulo,is_codigo_pallet,is_codigo_caja,istr_palarticulo)
	
	dw_detalle_bultos.retrieve(codigo_empresa,is_codigo_articulo,is_codigo_calidad,is_lote,ii_calibre,is_codigo_pallet,is_codigo_caja)
	
	this.st_descripcion.text = '['+is_codigo_articulo+'] '+is_descripcion_articulo+' CL='+is_codigo_calidad+' LOTE='+is_lote+' C='+string(ii_calibre)+' CJ='+is_codigo_caja+' PLT='+is_codigo_pallet
else
	st_descripcion.text = sle_codbar.text
	dw_detalle_bultos.reset()
end if

//Chequeo articulo y lote
integer li_existe_articulo_lote
if is_codigo_articulo <> "" and is_lote <> "1" and istr_articulos.tono = 'S' then
	select isnull(sum(resultado.existe),0)
	into   :li_existe_articulo_lote
	from (select 1 as existe
			from  prodpartes_ot 
			where prodpartes_ot.articulo = :is_codigo_articulo
			and   prodpartes_ot.lote     = :is_lote
			union 
			select 1 as existe
			from  planificacion 
			where planificacion.cod_articulo = :is_codigo_articulo
			and   planificacion.lote         = :is_lote) as resultado;
else
	li_existe_articulo_lote = 1			
end if
//

if is_codigo_articulo <> "" then
	if li_existe_articulo_lote = 0 and istr_articulos.tono = 'S' then
		f_grabar_incidencia("LECTURA EAN128","LOTE ERRONEO "+this.sle_codbar.text)
		messagebox("¡Error!","No existe el lote para el articulo seleccionado")
		//f_reset()
		this.event ue_siguiente_objeto()
	else
		this.event ue_siguiente_objeto()
	end if
else
	f_reset()
end if

/* Ejemplo un poco raro
program GS1;
 
{$APPTYPE CONSOLE}
 
uses
  Windows, SysUtils, Classes;  
 
type
  TRegTipo = (rtTexto, rtNumero, rtFecha, rtEAN13);
 
  TRegUnidades = (ruNinguna, ruKg, ruMetros, ruMetros2, ruMetros3, ruLitros,
    ruLibras, ruPulgadas, ruPulgadas2, ruPulgadas3, ruPies, ruPies2, ruPies3,
    ruYardas, ruYardas2, ruYardas3, ruOnzas, ruQuarts, ruGalones);
 
  TRegistro = record
    AI: String;
    Tipo: TRegTipo;
    Valor: String;
    Decimales: Integer;
    Unidades: TRegUnidades;
    Descripcion: String;
  end;
 
function LeerRegistro(var Codigo: String): TRegistro;
var
  C: Char;
begin
  if Copy(Codigo,1,2) = '00' then
    with Result do
    begin
      AI:= '00';
      Valor:= Copy(Codigo,3,18);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Shipping Container';
      Delete(Codigo,1,20);
    end else
  if Copy(Codigo,1,2) = '01' then
    with Result do
    begin
      AI:= '01';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Shipping Container Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '02' then
    with Result do
    begin
      AI:= '02';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of containers';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '10' then
    with Result do
    begin
      AI:= '10';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Batch Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '11' then
    with Result do
    begin
      AI:= '11';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Production Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '13' then
    with Result do
    begin
      AI:= '13';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Packaging Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '15' then
    with Result do
    begin
      AI:= '15';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Sell by Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '17' then
    with Result do
    begin
      AI:= '17';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Expiration Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '20' then
    with Result do
    begin
      AI:= '20';
      Valor:= Copy(Codigo,3,2);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Product Variant';
      Delete(Codigo,1,4);
    end else
  if Copy(Codigo,1,2) = '21' then
    with Result do
    begin
      AI:= '21';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,3) = '310' then
    with Result do
    begin
      AI:= '310';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '311' then
    with Result do
    begin
      AI:= '311';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '312' then
    with Result do
    begin
      AI:= '312';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '313' then
    with Result do
    begin
      AI:= '313';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '314' then
    with Result do
    begin
      AI:= '314';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '315' then
    with Result do
    begin
      AI:= '315';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '316' then
    with Result do
    begin
      AI:= '316';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '320' then
    with Result do
    begin
      AI:= '320';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '321' then
    with Result do
    begin
      AI:= '321';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '322' then
    with Result do
    begin
      AI:= '322';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '323' then
    with Result do
    begin
      AI:= '323';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '324' then
    with Result do
    begin
      AI:= '324';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '325' then
    with Result do
    begin
      AI:= '325';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '326' then
    with Result do
    begin
      AI:= '326';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '327' then
    with Result do
    begin
      AI:= '327';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '328' then
    with Result do
    begin
      AI:= '328';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '329' then
    with Result do
    begin
      AI:= '329';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '330' then
    with Result do
    begin
      AI:= '330';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '331' then
    with Result do
    begin
      AI:= '331';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '332' then
    with Result do
    begin
      AI:= '332';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '333' then
    with Result do
    begin
      AI:= '333';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '334' then
    with Result do
    begin
      AI:= '334';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '335' then
    with Result do
    begin
      AI:= '335';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '336' then
    with Result do
    begin
      AI:= '336';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '340' then
    with Result do
    begin
      AI:= '340';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '341' then
    with Result do
    begin
      AI:= '341';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '342' then
    with Result do
    begin
      AI:= '342';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '344' then
    with Result do
    begin
      AI:= '344';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Width/Diamater/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '345' then
    with Result do
    begin
      AI:= '345';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '346' then
    with Result do
    begin
      AI:= '346';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '347' then
    with Result do
    begin
      AI:= '347';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '348' then
    with Result do
    begin
      AI:= '348';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '349' then
    with Result do
    begin
      AI:= '349';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '350' then
    with Result do
    begin
      AI:= '350';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '351' then
    with Result do
    begin
      AI:= '351';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '352' then
    with Result do
    begin
      AI:= '352';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '353' then
    with Result do
    begin
      AI:= '353';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '354' then
    with Result do
    begin
      AI:= '354';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '355' then
    with Result do
    begin
      AI:= '355';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '356' then
    with Result do
    begin
      AI:= '356';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruOnzas;
      Descripcion:= 'Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '360' then
    with Result do
    begin
      AI:= '360';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '361' then
    with Result do
    begin
      AI:= '361';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '362' then
    with Result do
    begin
      AI:= '362';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '363' then
    with Result do
    begin
      AI:= '363';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '364' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '365' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '366' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '367' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '368' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '369' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,2) = '37' then
    with Result do
    begin
      AI:= '37';
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of Units Contained';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '400' then
    with Result do
    begin
      AI:= '400';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Customer Purchase Order Number';
      Delete(Codigo,1,3);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '410' then
    with Result do
    begin
      AI:= '410';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Ship To/Deliver To Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '411' then
    with Result do
    begin
      AI:= '411';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Bill To/Invoice Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '412' then
    with Result do
    begin
      AI:= '412';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Purchase From Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '8001' then
    with Result do
    begin
      AI:= '8001';
      Valor:= Copy(Codigo,5,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Roll Products - Width/Length/Core Diameter';
      Delete(Codigo,1,18);
    end else
  if Copy(Codigo,1,2) = '8004' then
    with Result do
    begin
      AI:= '8004';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'UPC/EAN Serial Identification';
      Delete(Codigo,1,4);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '8005' then
    with Result do
    begin
      AI:= '8005';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Price per Unit of Measure';
      Delete(Codigo,1,10);
    end else
      raise Exception.Create('AI desconocido');
end;
 
function UnidToStr(Unidad: TRegUnidades): String;
begin
  case Unidad of
    ruNinguna: Result:= EmptyStr;
    ruKg: Result:= 'Kilogramos';
    ruMetros: Result:= 'Metros';
    ruMetros2: Result:= 'Metros cuadrados';
    ruMetros3: Result:= 'Metros cubicos';
    ruLitros: Result:= 'Litros';
    ruLibras: Result:= 'Libras';
    ruPulgadas: Result:= 'Pulgadas';
    ruPulgadas2: Result:= 'Pulgadas cuadradas';
    ruPulgadas3: Result:= 'Pulgadas cubicas';
    ruPies: Result:= 'Pies';
    ruPies2: Result:= 'Pies cuadrados';
    ruPies3: Result:= 'Pies cubicos';
    ruYardas: Result:= 'Yardas';
    ruYardas2: Result:= 'Yardas cuadradas';
    ruYardas3: Result:= 'Yardas cubicas';
    ruOnzas: Result:= 'Onzas';
    ruQuarts: Result:= 'Quarts';
    ruGalones: Result:= 'Galones';
  end;
end;
 
 
var
  Str: String;
  i: Integer;
  d: Double;
  Registro: TRegistro;
begin
  while TRUE do
  try
    Readln(Str);
    while Str <> EmptyStr do
    begin
      Writeln;
      Registro:= LeerRegistro(Str);
      Writeln('AI: ' + Registro.AI);
      Writeln('Descr: ' + Registro.Descripcion);
      Writeln('Valor: ' + Registro.Valor);
      case Registro.Tipo of
        rtTexto:  Writeln('Tipo: Texto');
        rtNumero:
          begin
            Writeln('Tipo: Numero');
            Writeln('Decimales: ' + IntToStr(Registro.Decimales));
            Writeln('Unidades: ' + UnidToStr(Registro.Unidades));
            d:= StrToFloat(Registro.Valor);
            i:= Registro.Decimales;
            while i>0 do
            begin
              d:= d / 10;
              dec(i);
            end;
            Writeln('Valor: ' + FloatToStr(d));
          end;
        rtFecha:
          begin
            Writeln('Tipo: Fecha');
            with Registro do
              Writeln('Fecha: ' + Copy(Valor,5,2) + '/' + Copy(Valor,3,2)
                + '/' + Copy(Valor,1,2));
          end;
        rtEAN13:  Writeln('Tipo: EAN13');
      end;
    end;
    Writeln;
  except
    On E: Exception do
    begin
      Writeln;
      Writeln('Error al leer codigo');
      Writeln;
    end;
  end;
end.
*/
end subroutine

public subroutine f_leer_ean128_caja_bulto ();string ls_codigo_articulo,ls_descripcion_articulo,ls_codigo_calidad,ls_lote,ls_codigo_pallet,ls_codigo_caja
string ls_ean128,ls_ean13,ls_busqueda
int    li_calibre

ls_ean128 = this.sle_codbar_caja_bulto.text

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta,ll_row_detalle_actual
string ls_campo_busco

ll_row_detalle_actual = dw_detalle_bultos.getrow()

//Ean13
ls_campo_busco = "(01)"

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :ls_codigo_articulo, 
			 :ls_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(ls_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :ls_codigo_articulo, 
				 :ls_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	//Calidad
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		li_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = "(240)"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	ls_busqueda = "alm_bultos_lineas_articulo    = '"+ls_codigo_articulo+"' "+&	
					  "and alm_bultos_lineas_calidad = '"+ls_codigo_calidad+"' "+&	
					  "and alm_bultos_lineas_tono    = '"+ls_lote+"' "+&	
					  "and alm_bultos_lineas_calibre = "+string(li_calibre,"#0")+" "+&	
					  "and alm_bultos_lineas_caja    = '"+ls_codigo_caja+"' "
					  
	ll_donde = dw_detalle_bultos.find(ls_busqueda,1,dw_detalle_bultos.rowcount()) 
	
	if ll_donde > 0 then
		dw_detalle_bultos.event rowfocuschanged(ll_donde)
		dw_detalle_bultos.scrolltorow(ll_donde)
		
		event ue_siguiente_objeto()
	else
		//No encuentro esa caja en el bulto
		sle_codbar_caja_bulto.event getfocus()
	end if
else
	//No puedo leer el ean128
	sle_codbar_caja_bulto.event getfocus()
end if
end subroutine

public subroutine f_leer_ean128_eng_caja_bulto ();string ls_codigo_articulo,ls_descripcion_articulo,ls_codigo_calidad,ls_lote,ls_codigo_pallet,ls_codigo_caja
string ls_ean128,ls_ean13,ls_busqueda
int    li_calibre

ls_ean128 = this.sle_codbar_caja_bulto.text

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta,ll_row_detalle_actual
string ls_campo_busco

ll_row_detalle_actual = dw_detalle_bultos.getrow()

//Ean13
ls_campo_busco = ")01="

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :ls_codigo_articulo, 
			 :ls_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(ls_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :ls_codigo_articulo, 
				 :ls_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	//Calidad
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		li_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = ")240="
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	ls_busqueda = "alm_bultos_lineas_articulo    = '"+ls_codigo_articulo+"' "+&	
					  "and alm_bultos_lineas_calidad = '"+ls_codigo_calidad+"' "+&	
					  "and alm_bultos_lineas_tono    = '"+ls_lote+"' "+&	
					  "and alm_bultos_lineas_calibre = "+string(li_calibre,"#0")+" "+&	
					  "and alm_bultos_lineas_caja    = '"+ls_codigo_caja+"' "
					  
	ll_donde = dw_detalle_bultos.find(ls_busqueda,1,dw_detalle_bultos.rowcount()) 
	
	if ll_donde > 0 then
		dw_detalle_bultos.event rowfocuschanged(ll_donde)
		dw_detalle_bultos.scrolltorow(ll_donde)
		
		event ue_siguiente_objeto()
	else
		//No encuentro esa caja en el bulto
		sle_codbar_caja_bulto.event getfocus()
	end if
else
	//No puedo leer el ean128
	sle_codbar_caja_bulto.event getfocus()
end if
end subroutine

public subroutine f_leer_ubicacion_para_bulto ();string ls_ean13,ls_activo,ls_gestionar_en_piezas,ls_permitir_reservas 
long   ll_color_fondo,ll_color_texto 

string ls_almacen,ls_zona
int    li_fila,li_altura
long   ll_id_ubicacion,ll_rows
long   ll_almubimapa_codbar_id_alm_bultos

ls_ean13 = this.sle_codbar_ubicacion.text

select isnull(almubimapa_codbar.almacen,''),
		 isnull(almubimapa_codbar.zona,''),
		 isnull(almubimapa_codbar.fila,''),
		 isnull(almubimapa_codbar.altura,''),
		 isnull(almubimapa_codbar.id,0),
		 isnull(almubimapa_codbar.activo,''),
		 isnull(almubimapa_codbar.color_fondo,0),
		 isnull(almubimapa_codbar.color_texto,0), 
		 isnull(almubimapa_codbar.id_alm_bultos,0), 
		 isnull(almubimapa_codbar.gestionar_en_piezas,''), 
		 isnull(almubimapa_codbar.permitir_reservas,'') 
into   :is_almacen,
		 :is_zona,
		 :ii_fila,
		 :ii_altura,
		 :il_id_ubicacion,
		 :ls_activo,
		 :ll_color_fondo, 
		 :ll_color_texto, 
		 :ll_almubimapa_codbar_id_alm_bultos, 
		 :ls_gestionar_en_piezas,
		 :ls_permitir_reservas
from   almubimapa_codbar 
where  almubimapa_codbar.empresa = :codigo_empresa 
and    almubimapa_codbar.ean13   = :ls_ean13;

if ll_almubimapa_codbar_id_alm_bultos > 0 then
	ib_ubicacion_con_bulto_asociado = true	
else
	ib_ubicacion_con_bulto_asociado = false
end if

if ls_gestionar_en_piezas = 'S' then
	ib_ubicacion_gestionada_en_piezas = true
else
	ib_ubicacion_gestionada_en_piezas = false
end if

if ls_permitir_reservas = 'N' then
	ib_ubicacion_permite_reservas = false
else
	ib_ubicacion_permite_reservas = true
end if

if il_id_ubicacion = 0 or ib_ubicacion_con_bulto_asociado then
	//No existe ubicacion o tiene bulto asociado
	this.sle_codbar_ubicacion.event getfocus()
else
	f_cambia_ubicacion_bulto()
	event ue_siguiente_objeto()
end if
end subroutine

public function boolean f_cambia_ubicacion_bulto ();//Cambiamos la ubicacion del bulto
long ll_indice,ll_color_fondo,ll_color_texto,ll_almubimapa_codbar_id_alm_bultos
string ls_gestionar_en_piezas,ls_activo,ls_permitir_reservas

if il_id_ubicacion > 0 then
	select isnull(almubimapa_codbar.almacen,''),
			 isnull(almubimapa_codbar.zona,''),
			 isnull(almubimapa_codbar.fila,''),
			 isnull(almubimapa_codbar.altura,''),
			 isnull(almubimapa_codbar.activo,''),
			 isnull(almubimapa_codbar.color_fondo,0),
			 isnull(almubimapa_codbar.color_texto,0), 
			 isnull(almubimapa_codbar.id_alm_bultos,0), 
			 isnull(almubimapa_codbar.gestionar_en_piezas,''), 
		    isnull(almubimapa_codbar.permitir_reservas,'')  
	into   :is_almacen,
			 :is_zona,
			 :ii_fila,
			 :ii_altura,
			 :ls_activo,
			 :ll_color_fondo, 
			 :ll_color_texto, 
			 :ll_almubimapa_codbar_id_alm_bultos, 
			 :ls_gestionar_en_piezas,
			 :ls_permitir_reservas 
	from   almubimapa_codbar 
	where  almubimapa_codbar.empresa = :codigo_empresa 
	and    almubimapa_codbar.id      = :il_id_ubicacion;
else
	select isnull(almubimapa_codbar.id,0),
			 isnull(almubimapa_codbar.activo,''),
			 isnull(almubimapa_codbar.color_fondo,0),
			 isnull(almubimapa_codbar.color_texto,0), 
			 isnull(almubimapa_codbar.id_alm_bultos,0), 
			 isnull(almubimapa_codbar.gestionar_en_piezas,''), 
		    isnull(almubimapa_codbar.permitir_reservas,'') 
	into   :il_id_ubicacion,
			 :ls_activo,
			 :ll_color_fondo, 
			 :ll_color_texto, 
			 :ll_almubimapa_codbar_id_alm_bultos, 
			 :ls_gestionar_en_piezas,
			 :ls_permitir_reservas 
	from   almubimapa_codbar 
	where  almubimapa_codbar.empresa = :codigo_empresa 
	and    almubimapa_codbar.almacen = :is_almacen
	and    almubimapa_codbar.zona    = :is_zona
	and    almubimapa_codbar.fila    = :ii_fila
	and    almubimapa_codbar.altura  = :ii_altura;	
end if

if ii_lineas_bulto = 0 then
	ib_insertando_row = true
	dw_detalle_bultos.insertrow(0)
	dw_detalle_bultos.object.alm_bultos_anyo_orden_carga[1]         = 0
	dw_detalle_bultos.object.alm_bultos_codigo_orden_carga[1]       = ''
	dw_detalle_bultos.object.alm_bultos_lineas_linea_orden_carga[1] = 0
	ii_lineas_bulto = 1
	ib_insertando_row = false
end if

if ls_gestionar_en_piezas = 'S' then
	ib_ubicacion_gestionada_en_piezas = true
else
	ib_ubicacion_gestionada_en_piezas = false
end if

if ll_almubimapa_codbar_id_alm_bultos > 0 then
	ib_ubicacion_con_bulto_asociado = true
	il_id_bulto = ll_almubimapa_codbar_id_alm_bultos
else
	ib_ubicacion_con_bulto_asociado = false
end if

if ls_permitir_reservas = 'N' then
	ib_ubicacion_permite_reservas = false
else
	ib_ubicacion_permite_reservas = true
end if

for ll_indice = 1 to ii_lineas_bulto	
	dw_detalle_bultos.object.almubimapa_codbar_id[ll_indice]          = il_id_ubicacion
	dw_detalle_bultos.object.almubimapa_codbar_almacen[ll_indice]     = is_almacen
	dw_detalle_bultos.object.almubimapa_codbar_zona[ll_indice]        = is_zona
	dw_detalle_bultos.object.almubimapa_codbar_fila[ll_indice]        = ii_fila
	dw_detalle_bultos.object.almubimapa_codbar_altura[ll_indice]      = ii_altura 
	dw_detalle_bultos.object.almubimapa_codbar_color_fondo[ll_indice] = ll_color_fondo
	dw_detalle_bultos.object.almubimapa_codbar_color_texto[ll_indice] = ll_color_texto
	
	if ib_ubicacion_con_bulto_asociado then
		dw_detalle_bultos.object.alm_bultos_id[ll_indice] = il_id_bulto
		dw_detalle_bultos.object.alm_bultos_tipo_pallet[ll_indice] = "00000" //Las ubicaciones con bulto asociado siempre usan este tipo de pallet
	end if
	dw_detalle_bultos.groupcalc()
next

return true
end function

public subroutine f_calculo_disponible_linea ();long ll_bultos_mismo_art_especif

il_piezas_reservadas_bulto = 0
il_piezas_disponibles_totales = 0

SELECT ISNULL(COUNT(DISTINCT(alm_bultos.id)),0)
INTO   :ll_bultos_mismo_art_especif
FROM   alm_bultos,   
		 alm_bultos_lineas  
WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
and ( ( alm_bultos.empresa         = :codigo_empresa ) 
AND  	( alm_bultos_lineas.articulo = :is_codigo_articulo ) 
AND  	( alm_bultos_lineas.calidad  = :is_codigo_calidad ) 
AND  	( alm_bultos_lineas.tono     = :is_lote ) 
AND  	( alm_bultos_lineas.calibre  = :ii_calibre ) 
AND  	( alm_bultos_lineas.caja     = :is_codigo_caja ) );
//AND  	( alm_bultos.tipo_pallet     = :is_codigo_pallet ) );

il_piezas_disponibles_totales = f_disponible_art_cal_to_ca_tp_c_pzs_total( codigo_empresa , &
																	  						is_codigo_articulo , &
																	  						is_codigo_calidad , &
																	  						is_lote , &
																	  						ii_calibre , &
																	  						is_codigo_pallet , &
																	  						is_codigo_caja )	
	
if ll_bultos_mismo_art_especif = 1 then
	il_piezas_reservadas_bulto = f_reservado_art_cal_to_ca_tp_c_pzs( codigo_empresa , &
																						  is_codigo_articulo , &
																						  is_codigo_calidad , &
																						  is_lote , &
																						  ii_calibre , &
																						  is_codigo_pallet , &
																						  is_codigo_caja )	
	
else	

	if ib_nueva_gestion_de_reservas then
		SELECT isnull( (select sum(venliped_reservas.cantidad) from venliped_reservas where venliped_reservas.alm_bultos_lineas_id = alm_bultos_lineas.id ),0) as reservado 
		INTO   :il_piezas_reservadas_bulto 
		FROM   alm_bultos_lineas, 
				 alm_bultos, 
				 almubimapa_codbar, 
				 articulos, 
				 formatos, 
				 calidades, 
				 pallets, 
				 almcajas 
		WHERE  alm_bultos_lineas.id_alm_bultos = alm_bultos.id 
		AND    alm_bultos.id_ubicacion         = almubimapa_codbar.id 
		AND    alm_bultos_lineas.empresa       = articulos.empresa 
		AND    alm_bultos_lineas.articulo      = articulos.codigo 
		AND    articulos.empresa               = formatos.empresa 
		AND    articulos.formato               = formatos.codigo 
		AND    alm_bultos_lineas.empresa      *= calidades.empresa 
		AND    alm_bultos_lineas.calidad      *= calidades.codigo 
		AND    alm_bultos.empresa             *= pallets.empresa 
		AND    alm_bultos.tipo_pallet         *= pallets.codigo 
		AND    alm_bultos_lineas.empresa      *= almcajas.empresa 
		AND    alm_bultos_lineas.caja         *= almcajas.codigo 
		AND    alm_bultos.empresa              = :codigo_empresa 
		AND    alm_bultos.id                   = :il_id_bulto 
		AND    alm_bultos_lineas.id            = :il_alm_bultos_lineas_id; 
	
	else
		SELECT isnull( (select sum(orden_carga_linea_reservas.cantidad) from orden_carga_linea_reservas, orden_carga_linea, venliped where orden_carga_linea_reservas.empresa = orden_carga_linea.empresa and orden_carga_linea_reservas.anyo = orden_carga_linea.anyo and orden_carga_linea_reservas.codigo = orden_carga_linea.codigo and orden_carga_linea_reservas.linea = orden_carga_linea.linea and orden_carga_linea.empresa = venliped.empresa and orden_carga_linea.venliped_anyo = venliped.anyo and orden_carga_linea.venliped_pedido = venliped.pedido and orden_carga_linea.venliped_linea = venliped.linea and orden_carga_linea_reservas.id_alm_bultos = isnull(alm_bultos.id,0) and venliped.empresa = isnull(alm_bultos.empresa,'') and venliped.articulo = isnull(alm_bultos_lineas.articulo,'') and venliped.calidad = isnull(alm_bultos_lineas.calidad,'') and venliped.tonochar = isnull(alm_bultos_lineas.tono,'') and venliped.calibre = isnull(alm_bultos_lineas.calibre,0) and venliped.caja = isnull(alm_bultos_lineas.caja,'') ),0) as reservado
		INTO   :il_piezas_reservadas_bulto
		FROM   alm_bultos_lineas, 
				 alm_bultos, 
				 almubimapa_codbar, 
				 articulos, 
				 formatos, 
				 calidades, 
				 pallets, 
				 almcajas 
		WHERE  alm_bultos_lineas.id_alm_bultos = alm_bultos.id 
		AND    alm_bultos.id_ubicacion         = almubimapa_codbar.id 
		AND    alm_bultos_lineas.empresa       = articulos.empresa 
		AND    alm_bultos_lineas.articulo      = articulos.codigo 
		AND    articulos.empresa               = formatos.empresa 
		AND    articulos.formato               = formatos.codigo 
		AND    alm_bultos_lineas.empresa      *= calidades.empresa 
		AND    alm_bultos_lineas.calidad      *= calidades.codigo 
		AND    alm_bultos.empresa             *= pallets.empresa 
		AND    alm_bultos.tipo_pallet         *= pallets.codigo 
		AND    alm_bultos_lineas.empresa      *= almcajas.empresa 
		AND    alm_bultos_lineas.caja         *= almcajas.codigo 
		AND    alm_bultos.empresa              = :codigo_empresa 
		AND    alm_bultos.id                   = :il_id_bulto 
		AND    alm_bultos_lineas.id            = :il_alm_bultos_lineas_id; 
		
	end if
	
	if il_piezas_reservadas_bulto = 0 then
		if il_piezas > il_piezas_disponibles_totales then
			//Si el bulto tiene mas piezas que el total disponible tomaremos la diferencia como piezas reservadas
			il_piezas_reservadas_bulto = il_piezas - il_piezas_disponibles_totales
		end if
	end if
end if

il_piezas_disponibles_bulto = il_piezas - il_piezas_reservadas_bulto
end subroutine

public function boolean f_asignar_nueva_ubicacion (long arg_id_ubicacion_nueva);string ls_activo,ls_gestionar_en_piezas,ls_permitir_reservas 
long   ll_color_fondo,ll_color_texto 

string ls_almacen,ls_zona
int    li_fila,li_altura
long   ll_id_ubicacion,ll_rows
long   ll_almubimapa_codbar_id_alm_bultos

select isnull(almubimapa_codbar.almacen,''),
		 isnull(almubimapa_codbar.zona,''),
		 isnull(almubimapa_codbar.fila,''),
		 isnull(almubimapa_codbar.altura,''),
		 isnull(almubimapa_codbar.activo,''),
		 isnull(almubimapa_codbar.color_fondo,0),
		 isnull(almubimapa_codbar.color_texto,0), 
		 isnull(almubimapa_codbar.id_alm_bultos,0), 
		 isnull(almubimapa_codbar.gestionar_en_piezas,''), 
	    isnull(almubimapa_codbar.permitir_reservas,'') 
into   :is_almacen,
		 :is_zona,
		 :ii_fila,
		 :ii_altura,
		 :ls_activo,
		 :ll_color_fondo, 
		 :ll_color_texto, 
		 :ll_almubimapa_codbar_id_alm_bultos, 
		 :ls_gestionar_en_piezas,
		 :ls_permitir_reservas
from   almubimapa_codbar 
where  almubimapa_codbar.empresa = :codigo_empresa 
and    almubimapa_codbar.id      = :arg_id_ubicacion_nueva;

if trim(is_almacen) = '' then
	//No existe la nueva ubicación, volvemos a la ubicación anterior.
	select isnull(almubimapa_codbar.almacen,''),
			 isnull(almubimapa_codbar.zona,''),
			 isnull(almubimapa_codbar.fila,''),
			 isnull(almubimapa_codbar.altura,''),
			 isnull(almubimapa_codbar.activo,''),
			 isnull(almubimapa_codbar.color_fondo,0),
			 isnull(almubimapa_codbar.color_texto,0), 
			 isnull(almubimapa_codbar.id_alm_bultos,0), 
			 isnull(almubimapa_codbar.gestionar_en_piezas,''), 
		    isnull(almubimapa_codbar.permitir_reservas,'')  
	into   :is_almacen,
			 :is_zona,
			 :ii_fila,
			 :ii_altura,
			 :ls_activo,
			 :ll_color_fondo, 
			 :ll_color_texto, 
			 :ll_almubimapa_codbar_id_alm_bultos, 
			 :ls_gestionar_en_piezas,
			 :ls_permitir_reservas
	from   almubimapa_codbar 
	where  almubimapa_codbar.empresa = :codigo_empresa 
	and    almubimapa_codbar.id      = :il_id_ubicacion;
	
	return false
else
	il_id_ubicacion = arg_id_ubicacion_nueva
	
	if ll_almubimapa_codbar_id_alm_bultos > 0 then
		ib_ubicacion_con_bulto_asociado = true	
	else
		ib_ubicacion_con_bulto_asociado = false
	end if
	
	if ls_gestionar_en_piezas = 'S' then
		ib_ubicacion_gestionada_en_piezas = true
	else
		ib_ubicacion_gestionada_en_piezas = false
	end if
	
	if ls_permitir_reservas = 'N' then
		ib_ubicacion_permite_reservas = false
	else
		ib_ubicacion_permite_reservas = true
	end if	
	
	f_cambia_ubicacion_bulto()
	
//	if il_id_ubicacion = 0 or ib_ubicacion_con_bulto_asociado then
//		//No existe ubicacion o tiene bulto asociado
//		this.sle_codbar_ubicacion.event getfocus()
//	else
//		f_cambia_ubicacion_bulto()
//		event ue_siguiente_objeto()
//	end if
	
	return true	
end if


end function

public subroutine f_leer_ean128_prov ();string ls_codigo_articulo,ls_descripcion_articulo
string ls_ean128,ls_ean13

ls_ean128 = this.sle_codbar.text

f_inicializar_variables_instancia()

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta
string ls_campo_busco


//Ejemplo : [01]8434768000941[240]1-25551-5-2-1007
//Ean13 
ls_campo_busco = "[01]"

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :is_codigo_articulo, 
			 :is_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(is_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :is_codigo_articulo, 
				 :is_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	f_cargar_str_articulos(codigo_empresa,is_codigo_articulo,istr_articulos)
	
	//Calidad
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ii_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
	
	f_cargar_str_almartcajas(codigo_empresa,is_codigo_articulo,is_codigo_caja,istr_almartcajas)
	
	f_cargar_str_palarticulo(codigo_empresa,is_codigo_articulo,is_codigo_pallet,is_codigo_caja,istr_palarticulo)
	
	dw_detalle_bultos.retrieve(codigo_empresa,is_codigo_articulo,is_codigo_calidad,is_lote,ii_calibre,is_codigo_pallet,is_codigo_caja)
	
	this.st_descripcion.text = '['+is_codigo_articulo+'] '+is_descripcion_articulo+' CL='+is_codigo_calidad+' LOTE='+is_lote+' C='+string(ii_calibre)+' CJ='+is_codigo_caja+' PLT='+is_codigo_pallet
else
	st_descripcion.text = sle_codbar.text
	dw_detalle_bultos.reset()
end if

//Chequeo articulo y lote
integer li_existe_articulo_lote
if is_codigo_articulo <> "" and is_lote <> "1" and istr_articulos.tono = 'S' then
	select isnull(sum(resultado.existe),0)
	into   :li_existe_articulo_lote
	from (select 1 as existe
			from  prodpartes_ot 
			where prodpartes_ot.articulo = :is_codigo_articulo
			and   prodpartes_ot.lote     = :is_lote
			union 
			select 1 as existe
			from  planificacion 
			where planificacion.cod_articulo = :is_codigo_articulo
			and   planificacion.lote         = :is_lote) as resultado;
else
	li_existe_articulo_lote = 1			
end if
//

if is_codigo_articulo <> "" then
	if li_existe_articulo_lote = 0 and istr_articulos.tono = 'S' then
		f_grabar_incidencia("LECTURA EAN128","LOTE ERRONEO "+this.sle_codbar.text)
		messagebox("¡Error!","No existe el lote para el articulo seleccionado")
		//f_reset()
		this.event ue_siguiente_objeto()
	else
		this.event ue_siguiente_objeto()
	end if
else
	f_reset()
end if


/* Ejemplo un poco raro
program GS1;
 
{$APPTYPE CONSOLE}
 
uses
  Windows, SysUtils, Classes;  
 
type
  TRegTipo = (rtTexto, rtNumero, rtFecha, rtEAN13);
 
  TRegUnidades = (ruNinguna, ruKg, ruMetros, ruMetros2, ruMetros3, ruLitros,
    ruLibras, ruPulgadas, ruPulgadas2, ruPulgadas3, ruPies, ruPies2, ruPies3,
    ruYardas, ruYardas2, ruYardas3, ruOnzas, ruQuarts, ruGalones);
 
  TRegistro = record
    AI: String;
    Tipo: TRegTipo;
    Valor: String;
    Decimales: Integer;
    Unidades: TRegUnidades;
    Descripcion: String;
  end;
 
function LeerRegistro(var Codigo: String): TRegistro;
var
  C: Char;
begin
  if Copy(Codigo,1,2) = '00' then
    with Result do
    begin
      AI:= '00';
      Valor:= Copy(Codigo,3,18);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Shipping Container';
      Delete(Codigo,1,20);
    end else
  if Copy(Codigo,1,2) = '01' then
    with Result do
    begin
      AI:= '01';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Shipping Container Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '02' then
    with Result do
    begin
      AI:= '02';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of containers';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '10' then
    with Result do
    begin
      AI:= '10';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Batch Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '11' then
    with Result do
    begin
      AI:= '11';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Production Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '13' then
    with Result do
    begin
      AI:= '13';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Packaging Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '15' then
    with Result do
    begin
      AI:= '15';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Sell by Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '17' then
    with Result do
    begin
      AI:= '17';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Expiration Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '20' then
    with Result do
    begin
      AI:= '20';
      Valor:= Copy(Codigo,3,2);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Product Variant';
      Delete(Codigo,1,4);
    end else
  if Copy(Codigo,1,2) = '21' then
    with Result do
    begin
      AI:= '21';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,3) = '310' then
    with Result do
    begin
      AI:= '310';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '311' then
    with Result do
    begin
      AI:= '311';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '312' then
    with Result do
    begin
      AI:= '312';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '313' then
    with Result do
    begin
      AI:= '313';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '314' then
    with Result do
    begin
      AI:= '314';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '315' then
    with Result do
    begin
      AI:= '315';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '316' then
    with Result do
    begin
      AI:= '316';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '320' then
    with Result do
    begin
      AI:= '320';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '321' then
    with Result do
    begin
      AI:= '321';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '322' then
    with Result do
    begin
      AI:= '322';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '323' then
    with Result do
    begin
      AI:= '323';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '324' then
    with Result do
    begin
      AI:= '324';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '325' then
    with Result do
    begin
      AI:= '325';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '326' then
    with Result do
    begin
      AI:= '326';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '327' then
    with Result do
    begin
      AI:= '327';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '328' then
    with Result do
    begin
      AI:= '328';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '329' then
    with Result do
    begin
      AI:= '329';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '330' then
    with Result do
    begin
      AI:= '330';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '331' then
    with Result do
    begin
      AI:= '331';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '332' then
    with Result do
    begin
      AI:= '332';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '333' then
    with Result do
    begin
      AI:= '333';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '334' then
    with Result do
    begin
      AI:= '334';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '335' then
    with Result do
    begin
      AI:= '335';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '336' then
    with Result do
    begin
      AI:= '336';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '340' then
    with Result do
    begin
      AI:= '340';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '341' then
    with Result do
    begin
      AI:= '341';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '342' then
    with Result do
    begin
      AI:= '342';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '344' then
    with Result do
    begin
      AI:= '344';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Width/Diamater/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '345' then
    with Result do
    begin
      AI:= '345';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '346' then
    with Result do
    begin
      AI:= '346';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '347' then
    with Result do
    begin
      AI:= '347';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '348' then
    with Result do
    begin
      AI:= '348';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '349' then
    with Result do
    begin
      AI:= '349';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '350' then
    with Result do
    begin
      AI:= '350';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '351' then
    with Result do
    begin
      AI:= '351';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '352' then
    with Result do
    begin
      AI:= '352';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '353' then
    with Result do
    begin
      AI:= '353';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '354' then
    with Result do
    begin
      AI:= '354';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '355' then
    with Result do
    begin
      AI:= '355';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '356' then
    with Result do
    begin
      AI:= '356';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruOnzas;
      Descripcion:= 'Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '360' then
    with Result do
    begin
      AI:= '360';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '361' then
    with Result do
    begin
      AI:= '361';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '362' then
    with Result do
    begin
      AI:= '362';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '363' then
    with Result do
    begin
      AI:= '363';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '364' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '365' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '366' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '367' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '368' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '369' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,2) = '37' then
    with Result do
    begin
      AI:= '37';
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of Units Contained';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '400' then
    with Result do
    begin
      AI:= '400';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Customer Purchase Order Number';
      Delete(Codigo,1,3);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '410' then
    with Result do
    begin
      AI:= '410';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Ship To/Deliver To Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '411' then
    with Result do
    begin
      AI:= '411';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Bill To/Invoice Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '412' then
    with Result do
    begin
      AI:= '412';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Purchase From Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '8001' then
    with Result do
    begin
      AI:= '8001';
      Valor:= Copy(Codigo,5,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Roll Products - Width/Length/Core Diameter';
      Delete(Codigo,1,18);
    end else
  if Copy(Codigo,1,2) = '8004' then
    with Result do
    begin
      AI:= '8004';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'UPC/EAN Serial Identification';
      Delete(Codigo,1,4);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '8005' then
    with Result do
    begin
      AI:= '8005';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Price per Unit of Measure';
      Delete(Codigo,1,10);
    end else
      raise Exception.Create('AI desconocido');
end;
 
function UnidToStr(Unidad: TRegUnidades): String;
begin
  case Unidad of
    ruNinguna: Result:= EmptyStr;
    ruKg: Result:= 'Kilogramos';
    ruMetros: Result:= 'Metros';
    ruMetros2: Result:= 'Metros cuadrados';
    ruMetros3: Result:= 'Metros cubicos';
    ruLitros: Result:= 'Litros';
    ruLibras: Result:= 'Libras';
    ruPulgadas: Result:= 'Pulgadas';
    ruPulgadas2: Result:= 'Pulgadas cuadradas';
    ruPulgadas3: Result:= 'Pulgadas cubicas';
    ruPies: Result:= 'Pies';
    ruPies2: Result:= 'Pies cuadrados';
    ruPies3: Result:= 'Pies cubicos';
    ruYardas: Result:= 'Yardas';
    ruYardas2: Result:= 'Yardas cuadradas';
    ruYardas3: Result:= 'Yardas cubicas';
    ruOnzas: Result:= 'Onzas';
    ruQuarts: Result:= 'Quarts';
    ruGalones: Result:= 'Galones';
  end;
end;
 
 
var
  Str: String;
  i: Integer;
  d: Double;
  Registro: TRegistro;
begin
  while TRUE do
  try
    Readln(Str);
    while Str <> EmptyStr do
    begin
      Writeln;
      Registro:= LeerRegistro(Str);
      Writeln('AI: ' + Registro.AI);
      Writeln('Descr: ' + Registro.Descripcion);
      Writeln('Valor: ' + Registro.Valor);
      case Registro.Tipo of
        rtTexto:  Writeln('Tipo: Texto');
        rtNumero:
          begin
            Writeln('Tipo: Numero');
            Writeln('Decimales: ' + IntToStr(Registro.Decimales));
            Writeln('Unidades: ' + UnidToStr(Registro.Unidades));
            d:= StrToFloat(Registro.Valor);
            i:= Registro.Decimales;
            while i>0 do
            begin
              d:= d / 10;
              dec(i);
            end;
            Writeln('Valor: ' + FloatToStr(d));
          end;
        rtFecha:
          begin
            Writeln('Tipo: Fecha');
            with Registro do
              Writeln('Fecha: ' + Copy(Valor,5,2) + '/' + Copy(Valor,3,2)
                + '/' + Copy(Valor,1,2));
          end;
        rtEAN13:  Writeln('Tipo: EAN13');
      end;
    end;
    Writeln;
  except
    On E: Exception do
    begin
      Writeln;
      Writeln('Error al leer codigo');
      Writeln;
    end;
  end;
end.
*/
end subroutine

public subroutine f_leer_ean128_prov_caja_bulto ();string ls_codigo_articulo,ls_descripcion_articulo,ls_codigo_calidad,ls_lote,ls_codigo_pallet,ls_codigo_caja
string ls_ean128,ls_ean13,ls_busqueda
int    li_calibre

ls_ean128 = this.sle_codbar_caja_bulto.text

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta,ll_row_detalle_actual
string ls_campo_busco

ll_row_detalle_actual = dw_detalle_bultos.getrow()

//Ejemplo [01]8434768000941[240]1-25551-5-2-1007
//Ean13
ls_campo_busco = "[01]"

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :ls_codigo_articulo, 
			 :ls_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(ls_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :ls_codigo_articulo, 
				 :ls_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	//Calidad
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		li_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = "[240]"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"-",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	ls_busqueda = "alm_bultos_lineas_articulo    = '"+ls_codigo_articulo+"' "+&	
					  "and alm_bultos_lineas_calidad = '"+ls_codigo_calidad+"' "+&	
					  "and alm_bultos_lineas_tono    = '"+ls_lote+"' "+&	
					  "and alm_bultos_lineas_calibre = "+string(li_calibre,"#0")+" "+&	
					  "and alm_bultos_lineas_caja    = '"+ls_codigo_caja+"' "
					  
	ll_donde = dw_detalle_bultos.find(ls_busqueda,1,dw_detalle_bultos.rowcount()) 
	
	if ll_donde > 0 then
		dw_detalle_bultos.event rowfocuschanged(ll_donde)
		dw_detalle_bultos.scrolltorow(ll_donde)
		
		event ue_siguiente_objeto()
	else
		//No encuentro esa caja en el bulto
		sle_codbar_caja_bulto.event getfocus()
	end if
else
	//No puedo leer el ean128
	sle_codbar_caja_bulto.event getfocus()
end if
end subroutine

public subroutine f_leer_ean128_prov_eng ();string ls_codigo_articulo,ls_descripcion_articulo
string ls_ean128,ls_ean13

ls_ean128 = this.sle_codbar.text

f_inicializar_variables_instancia()

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta
string ls_campo_busco


//Ejemplo : `01+8434768000941`240+1'25551'5'2'1007
//Ean13 
ls_campo_busco = "`01+"

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :is_codigo_articulo, 
			 :is_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(is_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :is_codigo_articulo, 
				 :is_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	f_cargar_str_articulos(codigo_empresa,is_codigo_articulo,istr_articulos)
	
	//Calidad
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ii_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
	
	f_cargar_str_almartcajas(codigo_empresa,is_codigo_articulo,is_codigo_caja,istr_almartcajas)
	
	f_cargar_str_palarticulo(codigo_empresa,is_codigo_articulo,is_codigo_pallet,is_codigo_caja,istr_palarticulo)
	
	dw_detalle_bultos.retrieve(codigo_empresa,is_codigo_articulo,is_codigo_calidad,is_lote,ii_calibre,is_codigo_pallet,is_codigo_caja)
	
	this.st_descripcion.text = '['+is_codigo_articulo+'] '+is_descripcion_articulo+' CL='+is_codigo_calidad+' LOTE='+is_lote+' C='+string(ii_calibre)+' CJ='+is_codigo_caja+' PLT='+is_codigo_pallet
else
	st_descripcion.text = sle_codbar.text
	dw_detalle_bultos.reset()
end if

//Chequeo articulo y lote
integer li_existe_articulo_lote
if is_codigo_articulo <> "" and is_lote <> "1" and istr_articulos.tono = 'S' then
	select isnull(sum(resultado.existe),0)
	into   :li_existe_articulo_lote
	from (select 1 as existe
			from  prodpartes_ot 
			where prodpartes_ot.articulo = :is_codigo_articulo
			and   prodpartes_ot.lote     = :is_lote
			union 
			select 1 as existe
			from  planificacion 
			where planificacion.cod_articulo = :is_codigo_articulo
			and   planificacion.lote         = :is_lote) as resultado;
else
	li_existe_articulo_lote = 1			
end if
//

if is_codigo_articulo <> "" then
	if li_existe_articulo_lote = 0 and istr_articulos.tono = 'S' then
		f_grabar_incidencia("LECTURA EAN128","LOTE ERRONEO "+this.sle_codbar.text)
		messagebox("¡Error!","No existe el lote para el articulo seleccionado")
		//f_reset()
		this.event ue_siguiente_objeto()
	else
		this.event ue_siguiente_objeto()
	end if
else
	f_reset()
end if


/* Ejemplo un poco raro
program GS1;
 
{$APPTYPE CONSOLE}
 
uses
  Windows, SysUtils, Classes;  
 
type
  TRegTipo = (rtTexto, rtNumero, rtFecha, rtEAN13);
 
  TRegUnidades = (ruNinguna, ruKg, ruMetros, ruMetros2, ruMetros3, ruLitros,
    ruLibras, ruPulgadas, ruPulgadas2, ruPulgadas3, ruPies, ruPies2, ruPies3,
    ruYardas, ruYardas2, ruYardas3, ruOnzas, ruQuarts, ruGalones);
 
  TRegistro = record
    AI: String;
    Tipo: TRegTipo;
    Valor: String;
    Decimales: Integer;
    Unidades: TRegUnidades;
    Descripcion: String;
  end;
 
function LeerRegistro(var Codigo: String): TRegistro;
var
  C: Char;
begin
  if Copy(Codigo,1,2) = '00' then
    with Result do
    begin
      AI:= '00';
      Valor:= Copy(Codigo,3,18);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Shipping Container';
      Delete(Codigo,1,20);
    end else
  if Copy(Codigo,1,2) = '01' then
    with Result do
    begin
      AI:= '01';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Shipping Container Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '02' then
    with Result do
    begin
      AI:= '02';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of containers';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '10' then
    with Result do
    begin
      AI:= '10';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Batch Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '11' then
    with Result do
    begin
      AI:= '11';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Production Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '13' then
    with Result do
    begin
      AI:= '13';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Packaging Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '15' then
    with Result do
    begin
      AI:= '15';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Sell by Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '17' then
    with Result do
    begin
      AI:= '17';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Expiration Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '20' then
    with Result do
    begin
      AI:= '20';
      Valor:= Copy(Codigo,3,2);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Product Variant';
      Delete(Codigo,1,4);
    end else
  if Copy(Codigo,1,2) = '21' then
    with Result do
    begin
      AI:= '21';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,3) = '310' then
    with Result do
    begin
      AI:= '310';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '311' then
    with Result do
    begin
      AI:= '311';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '312' then
    with Result do
    begin
      AI:= '312';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '313' then
    with Result do
    begin
      AI:= '313';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '314' then
    with Result do
    begin
      AI:= '314';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '315' then
    with Result do
    begin
      AI:= '315';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '316' then
    with Result do
    begin
      AI:= '316';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '320' then
    with Result do
    begin
      AI:= '320';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '321' then
    with Result do
    begin
      AI:= '321';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '322' then
    with Result do
    begin
      AI:= '322';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '323' then
    with Result do
    begin
      AI:= '323';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '324' then
    with Result do
    begin
      AI:= '324';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '325' then
    with Result do
    begin
      AI:= '325';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '326' then
    with Result do
    begin
      AI:= '326';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '327' then
    with Result do
    begin
      AI:= '327';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '328' then
    with Result do
    begin
      AI:= '328';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '329' then
    with Result do
    begin
      AI:= '329';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '330' then
    with Result do
    begin
      AI:= '330';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '331' then
    with Result do
    begin
      AI:= '331';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '332' then
    with Result do
    begin
      AI:= '332';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '333' then
    with Result do
    begin
      AI:= '333';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '334' then
    with Result do
    begin
      AI:= '334';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '335' then
    with Result do
    begin
      AI:= '335';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '336' then
    with Result do
    begin
      AI:= '336';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '340' then
    with Result do
    begin
      AI:= '340';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '341' then
    with Result do
    begin
      AI:= '341';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '342' then
    with Result do
    begin
      AI:= '342';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '344' then
    with Result do
    begin
      AI:= '344';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Width/Diamater/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '345' then
    with Result do
    begin
      AI:= '345';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '346' then
    with Result do
    begin
      AI:= '346';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '347' then
    with Result do
    begin
      AI:= '347';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '348' then
    with Result do
    begin
      AI:= '348';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '349' then
    with Result do
    begin
      AI:= '349';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '350' then
    with Result do
    begin
      AI:= '350';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '351' then
    with Result do
    begin
      AI:= '351';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '352' then
    with Result do
    begin
      AI:= '352';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '353' then
    with Result do
    begin
      AI:= '353';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '354' then
    with Result do
    begin
      AI:= '354';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '355' then
    with Result do
    begin
      AI:= '355';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '356' then
    with Result do
    begin
      AI:= '356';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruOnzas;
      Descripcion:= 'Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '360' then
    with Result do
    begin
      AI:= '360';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '361' then
    with Result do
    begin
      AI:= '361';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '362' then
    with Result do
    begin
      AI:= '362';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '363' then
    with Result do
    begin
      AI:= '363';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '364' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '365' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '366' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '367' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '368' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '369' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,2) = '37' then
    with Result do
    begin
      AI:= '37';
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of Units Contained';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '400' then
    with Result do
    begin
      AI:= '400';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Customer Purchase Order Number';
      Delete(Codigo,1,3);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '410' then
    with Result do
    begin
      AI:= '410';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Ship To/Deliver To Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '411' then
    with Result do
    begin
      AI:= '411';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Bill To/Invoice Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '412' then
    with Result do
    begin
      AI:= '412';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Purchase From Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '8001' then
    with Result do
    begin
      AI:= '8001';
      Valor:= Copy(Codigo,5,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Roll Products - Width/Length/Core Diameter';
      Delete(Codigo,1,18);
    end else
  if Copy(Codigo,1,2) = '8004' then
    with Result do
    begin
      AI:= '8004';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'UPC/EAN Serial Identification';
      Delete(Codigo,1,4);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '8005' then
    with Result do
    begin
      AI:= '8005';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Price per Unit of Measure';
      Delete(Codigo,1,10);
    end else
      raise Exception.Create('AI desconocido');
end;
 
function UnidToStr(Unidad: TRegUnidades): String;
begin
  case Unidad of
    ruNinguna: Result:= EmptyStr;
    ruKg: Result:= 'Kilogramos';
    ruMetros: Result:= 'Metros';
    ruMetros2: Result:= 'Metros cuadrados';
    ruMetros3: Result:= 'Metros cubicos';
    ruLitros: Result:= 'Litros';
    ruLibras: Result:= 'Libras';
    ruPulgadas: Result:= 'Pulgadas';
    ruPulgadas2: Result:= 'Pulgadas cuadradas';
    ruPulgadas3: Result:= 'Pulgadas cubicas';
    ruPies: Result:= 'Pies';
    ruPies2: Result:= 'Pies cuadrados';
    ruPies3: Result:= 'Pies cubicos';
    ruYardas: Result:= 'Yardas';
    ruYardas2: Result:= 'Yardas cuadradas';
    ruYardas3: Result:= 'Yardas cubicas';
    ruOnzas: Result:= 'Onzas';
    ruQuarts: Result:= 'Quarts';
    ruGalones: Result:= 'Galones';
  end;
end;
 
 
var
  Str: String;
  i: Integer;
  d: Double;
  Registro: TRegistro;
begin
  while TRUE do
  try
    Readln(Str);
    while Str <> EmptyStr do
    begin
      Writeln;
      Registro:= LeerRegistro(Str);
      Writeln('AI: ' + Registro.AI);
      Writeln('Descr: ' + Registro.Descripcion);
      Writeln('Valor: ' + Registro.Valor);
      case Registro.Tipo of
        rtTexto:  Writeln('Tipo: Texto');
        rtNumero:
          begin
            Writeln('Tipo: Numero');
            Writeln('Decimales: ' + IntToStr(Registro.Decimales));
            Writeln('Unidades: ' + UnidToStr(Registro.Unidades));
            d:= StrToFloat(Registro.Valor);
            i:= Registro.Decimales;
            while i>0 do
            begin
              d:= d / 10;
              dec(i);
            end;
            Writeln('Valor: ' + FloatToStr(d));
          end;
        rtFecha:
          begin
            Writeln('Tipo: Fecha');
            with Registro do
              Writeln('Fecha: ' + Copy(Valor,5,2) + '/' + Copy(Valor,3,2)
                + '/' + Copy(Valor,1,2));
          end;
        rtEAN13:  Writeln('Tipo: EAN13');
      end;
    end;
    Writeln;
  except
    On E: Exception do
    begin
      Writeln;
      Writeln('Error al leer codigo');
      Writeln;
    end;
  end;
end.
*/
end subroutine

public subroutine f_leer_ean128_prov_eng_caja_bulto ();string ls_codigo_articulo,ls_descripcion_articulo,ls_codigo_calidad,ls_lote,ls_codigo_pallet,ls_codigo_caja
string ls_ean128,ls_ean13,ls_busqueda
int    li_calibre

ls_ean128 = this.sle_codbar_caja_bulto.text

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta,ll_row_detalle_actual
string ls_campo_busco

ll_row_detalle_actual = dw_detalle_bultos.getrow()

//Ejemplo `01+8434768000941`240+1'25551'5'2'1007
//Ean13
ls_campo_busco = "`01+"

ll_donde = pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :ls_codigo_articulo, 
			 :ls_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(ls_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :ls_codigo_articulo, 
				 :ls_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	//Calidad
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		li_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = "`240+"
	
	ll_donde = pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,"'",ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	ls_busqueda = "alm_bultos_lineas_articulo    = '"+ls_codigo_articulo+"' "+&	
					  "and alm_bultos_lineas_calidad = '"+ls_codigo_calidad+"' "+&	
					  "and alm_bultos_lineas_tono    = '"+ls_lote+"' "+&	
					  "and alm_bultos_lineas_calibre = "+string(li_calibre,"#0")+" "+&	
					  "and alm_bultos_lineas_caja    = '"+ls_codigo_caja+"' "
					  
	ll_donde = dw_detalle_bultos.find(ls_busqueda,1,dw_detalle_bultos.rowcount()) 
	
	if ll_donde > 0 then
		dw_detalle_bultos.event rowfocuschanged(ll_donde)
		dw_detalle_bultos.scrolltorow(ll_donde)
		
		event ue_siguiente_objeto()
	else
		//No encuentro esa caja en el bulto
		sle_codbar_caja_bulto.event getfocus()
	end if
else
	//No puedo leer el ean128
	sle_codbar_caja_bulto.event getfocus()
end if
end subroutine

public subroutine f_leer_ean128_sin_parentesis ();string ls_codigo_articulo,ls_descripcion_articulo
string ls_ean128,ls_ean13,ls_separador_campos = "-"

ls_ean128 = this.sle_codbar.text

f_inicializar_variables_instancia()

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta
string ls_campo_busco

//Vamos a operar con ancho fijo
//Ean13
//ls_campo_busco = "01"
ls_campo_busco = ""
ll_donde = 1//pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :is_codigo_articulo, 
			 :is_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(is_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :is_codigo_articulo, 
				 :is_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	f_cargar_str_articulos(codigo_empresa,is_codigo_articulo,istr_articulos)
	
	ls_ean128 = right(ls_ean128,len(ls_ean128) - ll_hasta)
	//Calidad
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ii_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
	
	f_cargar_str_almartcajas(codigo_empresa,is_codigo_articulo,is_codigo_caja,istr_almartcajas)
	
	f_cargar_str_palarticulo(codigo_empresa,is_codigo_articulo,is_codigo_pallet,is_codigo_caja,istr_palarticulo)
	
	dw_detalle_bultos.retrieve(codigo_empresa,is_codigo_articulo,is_codigo_calidad,is_lote,ii_calibre,is_codigo_pallet,is_codigo_caja)
	
	this.st_descripcion.text = '['+is_codigo_articulo+'] '+is_descripcion_articulo+' CL='+is_codigo_calidad+' LOTE='+is_lote+' C='+string(ii_calibre)+' CJ='+is_codigo_caja+' PLT='+is_codigo_pallet
else
	st_descripcion.text = sle_codbar.text
	dw_detalle_bultos.reset()
end if

//Chequeo articulo y lote
integer li_existe_articulo_lote
if is_codigo_articulo <> "" and is_lote <> "1" and istr_articulos.tono = 'S' then
	select isnull(sum(resultado.existe),0)
	into   :li_existe_articulo_lote
	from (select 1 as existe
			from  prodpartes_ot 
			where prodpartes_ot.articulo = :is_codigo_articulo
			and   prodpartes_ot.lote     = :is_lote
			union 
			select 1 as existe
			from  planificacion 
			where planificacion.cod_articulo = :is_codigo_articulo
			and   planificacion.lote         = :is_lote) as resultado;
else
	li_existe_articulo_lote = 1
end if
//

if is_codigo_articulo <> "" then
	if li_existe_articulo_lote = 0 and istr_articulos.tono = 'S' then
		f_grabar_incidencia("LECTURA EAN128","LOTE ERRONEO "+this.sle_codbar.text)
		messagebox("¡Error!","No existe el lote para el articulo seleccionado")
		//f_reset()
		this.event ue_siguiente_objeto()
	else
		this.event ue_siguiente_objeto()
	end if
else
	f_reset()
end if


/* Ejemplo un poco raro
program GS1;
 
{$APPTYPE CONSOLE}
 
uses
  Windows, SysUtils, Classes;  
 
type
  TRegTipo = (rtTexto, rtNumero, rtFecha, rtEAN13);
 
  TRegUnidades = (ruNinguna, ruKg, ruMetros, ruMetros2, ruMetros3, ruLitros,
    ruLibras, ruPulgadas, ruPulgadas2, ruPulgadas3, ruPies, ruPies2, ruPies3,
    ruYardas, ruYardas2, ruYardas3, ruOnzas, ruQuarts, ruGalones);
 
  TRegistro = record
    AI: String;
    Tipo: TRegTipo;
    Valor: String;
    Decimales: Integer;
    Unidades: TRegUnidades;
    Descripcion: String;
  end;
 
function LeerRegistro(var Codigo: String): TRegistro;
var
  C: Char;
begin
  if Copy(Codigo,1,2) = '00' then
    with Result do
    begin
      AI:= '00';
      Valor:= Copy(Codigo,3,18);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Shipping Container';
      Delete(Codigo,1,20);
    end else
  if Copy(Codigo,1,2) = '01' then
    with Result do
    begin
      AI:= '01';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Shipping Container Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '02' then
    with Result do
    begin
      AI:= '02';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of containers';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '10' then
    with Result do
    begin
      AI:= '10';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Batch Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '11' then
    with Result do
    begin
      AI:= '11';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Production Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '13' then
    with Result do
    begin
      AI:= '13';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Packaging Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '15' then
    with Result do
    begin
      AI:= '15';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Sell by Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '17' then
    with Result do
    begin
      AI:= '17';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Expiration Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '20' then
    with Result do
    begin
      AI:= '20';
      Valor:= Copy(Codigo,3,2);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Product Variant';
      Delete(Codigo,1,4);
    end else
  if Copy(Codigo,1,2) = '21' then
    with Result do
    begin
      AI:= '21';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,3) = '310' then
    with Result do
    begin
      AI:= '310';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '311' then
    with Result do
    begin
      AI:= '311';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '312' then
    with Result do
    begin
      AI:= '312';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '313' then
    with Result do
    begin
      AI:= '313';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '314' then
    with Result do
    begin
      AI:= '314';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '315' then
    with Result do
    begin
      AI:= '315';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '316' then
    with Result do
    begin
      AI:= '316';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '320' then
    with Result do
    begin
      AI:= '320';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '321' then
    with Result do
    begin
      AI:= '321';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '322' then
    with Result do
    begin
      AI:= '322';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '323' then
    with Result do
    begin
      AI:= '323';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '324' then
    with Result do
    begin
      AI:= '324';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '325' then
    with Result do
    begin
      AI:= '325';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '326' then
    with Result do
    begin
      AI:= '326';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '327' then
    with Result do
    begin
      AI:= '327';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '328' then
    with Result do
    begin
      AI:= '328';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '329' then
    with Result do
    begin
      AI:= '329';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '330' then
    with Result do
    begin
      AI:= '330';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '331' then
    with Result do
    begin
      AI:= '331';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '332' then
    with Result do
    begin
      AI:= '332';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '333' then
    with Result do
    begin
      AI:= '333';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '334' then
    with Result do
    begin
      AI:= '334';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '335' then
    with Result do
    begin
      AI:= '335';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '336' then
    with Result do
    begin
      AI:= '336';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '340' then
    with Result do
    begin
      AI:= '340';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '341' then
    with Result do
    begin
      AI:= '341';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '342' then
    with Result do
    begin
      AI:= '342';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '344' then
    with Result do
    begin
      AI:= '344';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Width/Diamater/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '345' then
    with Result do
    begin
      AI:= '345';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '346' then
    with Result do
    begin
      AI:= '346';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '347' then
    with Result do
    begin
      AI:= '347';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '348' then
    with Result do
    begin
      AI:= '348';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '349' then
    with Result do
    begin
      AI:= '349';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '350' then
    with Result do
    begin
      AI:= '350';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '351' then
    with Result do
    begin
      AI:= '351';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '352' then
    with Result do
    begin
      AI:= '352';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '353' then
    with Result do
    begin
      AI:= '353';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '354' then
    with Result do
    begin
      AI:= '354';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '355' then
    with Result do
    begin
      AI:= '355';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '356' then
    with Result do
    begin
      AI:= '356';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruOnzas;
      Descripcion:= 'Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '360' then
    with Result do
    begin
      AI:= '360';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '361' then
    with Result do
    begin
      AI:= '361';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '362' then
    with Result do
    begin
      AI:= '362';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '363' then
    with Result do
    begin
      AI:= '363';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '364' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '365' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '366' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '367' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '368' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '369' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,2) = '37' then
    with Result do
    begin
      AI:= '37';
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of Units Contained';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '400' then
    with Result do
    begin
      AI:= '400';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Customer Purchase Order Number';
      Delete(Codigo,1,3);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '410' then
    with Result do
    begin
      AI:= '410';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Ship To/Deliver To Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '411' then
    with Result do
    begin
      AI:= '411';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Bill To/Invoice Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '412' then
    with Result do
    begin
      AI:= '412';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Purchase From Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '8001' then
    with Result do
    begin
      AI:= '8001';
      Valor:= Copy(Codigo,5,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Roll Products - Width/Length/Core Diameter';
      Delete(Codigo,1,18);
    end else
  if Copy(Codigo,1,2) = '8004' then
    with Result do
    begin
      AI:= '8004';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'UPC/EAN Serial Identification';
      Delete(Codigo,1,4);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '8005' then
    with Result do
    begin
      AI:= '8005';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Price per Unit of Measure';
      Delete(Codigo,1,10);
    end else
      raise Exception.Create('AI desconocido');
end;
 
function UnidToStr(Unidad: TRegUnidades): String;
begin
  case Unidad of
    ruNinguna: Result:= EmptyStr;
    ruKg: Result:= 'Kilogramos';
    ruMetros: Result:= 'Metros';
    ruMetros2: Result:= 'Metros cuadrados';
    ruMetros3: Result:= 'Metros cubicos';
    ruLitros: Result:= 'Litros';
    ruLibras: Result:= 'Libras';
    ruPulgadas: Result:= 'Pulgadas';
    ruPulgadas2: Result:= 'Pulgadas cuadradas';
    ruPulgadas3: Result:= 'Pulgadas cubicas';
    ruPies: Result:= 'Pies';
    ruPies2: Result:= 'Pies cuadrados';
    ruPies3: Result:= 'Pies cubicos';
    ruYardas: Result:= 'Yardas';
    ruYardas2: Result:= 'Yardas cuadradas';
    ruYardas3: Result:= 'Yardas cubicas';
    ruOnzas: Result:= 'Onzas';
    ruQuarts: Result:= 'Quarts';
    ruGalones: Result:= 'Galones';
  end;
end;
 
 
var
  Str: String;
  i: Integer;
  d: Double;
  Registro: TRegistro;
begin
  while TRUE do
  try
    Readln(Str);
    while Str <> EmptyStr do
    begin
      Writeln;
      Registro:= LeerRegistro(Str);
      Writeln('AI: ' + Registro.AI);
      Writeln('Descr: ' + Registro.Descripcion);
      Writeln('Valor: ' + Registro.Valor);
      case Registro.Tipo of
        rtTexto:  Writeln('Tipo: Texto');
        rtNumero:
          begin
            Writeln('Tipo: Numero');
            Writeln('Decimales: ' + IntToStr(Registro.Decimales));
            Writeln('Unidades: ' + UnidToStr(Registro.Unidades));
            d:= StrToFloat(Registro.Valor);
            i:= Registro.Decimales;
            while i>0 do
            begin
              d:= d / 10;
              dec(i);
            end;
            Writeln('Valor: ' + FloatToStr(d));
          end;
        rtFecha:
          begin
            Writeln('Tipo: Fecha');
            with Registro do
              Writeln('Fecha: ' + Copy(Valor,5,2) + '/' + Copy(Valor,3,2)
                + '/' + Copy(Valor,1,2));
          end;
        rtEAN13:  Writeln('Tipo: EAN13');
      end;
    end;
    Writeln;
  except
    On E: Exception do
    begin
      Writeln;
      Writeln('Error al leer codigo');
      Writeln;
    end;
  end;
end.
*/
end subroutine

public subroutine f_leer_ean128_sin_parentesis_eng ();string ls_codigo_articulo,ls_descripcion_articulo
string ls_ean128,ls_ean13,ls_separador_campos = "'"

ls_ean128 = this.sle_codbar.text

f_inicializar_variables_instancia()

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta
string ls_campo_busco

//Vamos a operar con ancho fijo
//Ean13
//ls_campo_busco = "01"
ls_campo_busco = ""
ll_donde = 1//pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :is_codigo_articulo, 
			 :is_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(is_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :is_codigo_articulo, 
				 :is_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	f_cargar_str_articulos(codigo_empresa,is_codigo_articulo,istr_articulos)
	
	ls_ean128 = right(ls_ean128,len(ls_ean128) - ll_hasta)
	//Calidad
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ii_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		is_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
	
	f_cargar_str_almartcajas(codigo_empresa,is_codigo_articulo,is_codigo_caja,istr_almartcajas)
	
	f_cargar_str_palarticulo(codigo_empresa,is_codigo_articulo,is_codigo_pallet,is_codigo_caja,istr_palarticulo)
	
	dw_detalle_bultos.retrieve(codigo_empresa,is_codigo_articulo,is_codigo_calidad,is_lote,ii_calibre,is_codigo_pallet,is_codigo_caja)
	
	this.st_descripcion.text = '['+is_codigo_articulo+'] '+is_descripcion_articulo+' CL='+is_codigo_calidad+' LOTE='+is_lote+' C='+string(ii_calibre)+' CJ='+is_codigo_caja+' PLT='+is_codigo_pallet
else
	st_descripcion.text = sle_codbar.text
	dw_detalle_bultos.reset()
end if

//Chequeo articulo y lote
integer li_existe_articulo_lote
if is_codigo_articulo <> "" and is_lote <> "1" and istr_articulos.tono = 'S' then
	select isnull(sum(resultado.existe),0)
	into   :li_existe_articulo_lote
	from (select 1 as existe
			from  prodpartes_ot 
			where prodpartes_ot.articulo = :is_codigo_articulo
			and   prodpartes_ot.lote     = :is_lote
			union 
			select 1 as existe
			from  planificacion 
			where planificacion.cod_articulo = :is_codigo_articulo
			and   planificacion.lote         = :is_lote) as resultado;
else
	li_existe_articulo_lote = 1			
end if
//

if is_codigo_articulo <> "" then
	if li_existe_articulo_lote = 0 and istr_articulos.tono = 'S' then
		f_grabar_incidencia("LECTURA EAN128","LOTE ERRONEO "+this.sle_codbar.text)
		messagebox("¡Error!","No existe el lote para el articulo seleccionado")
		//f_reset()
		this.event ue_siguiente_objeto()
	else
		this.event ue_siguiente_objeto()
	end if
else
	f_reset()
end if


/* Ejemplo un poco raro
program GS1;
 
{$APPTYPE CONSOLE}
 
uses
  Windows, SysUtils, Classes;  
 
type
  TRegTipo = (rtTexto, rtNumero, rtFecha, rtEAN13);
 
  TRegUnidades = (ruNinguna, ruKg, ruMetros, ruMetros2, ruMetros3, ruLitros,
    ruLibras, ruPulgadas, ruPulgadas2, ruPulgadas3, ruPies, ruPies2, ruPies3,
    ruYardas, ruYardas2, ruYardas3, ruOnzas, ruQuarts, ruGalones);
 
  TRegistro = record
    AI: String;
    Tipo: TRegTipo;
    Valor: String;
    Decimales: Integer;
    Unidades: TRegUnidades;
    Descripcion: String;
  end;
 
function LeerRegistro(var Codigo: String): TRegistro;
var
  C: Char;
begin
  if Copy(Codigo,1,2) = '00' then
    with Result do
    begin
      AI:= '00';
      Valor:= Copy(Codigo,3,18);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Shipping Container';
      Delete(Codigo,1,20);
    end else
  if Copy(Codigo,1,2) = '01' then
    with Result do
    begin
      AI:= '01';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Shipping Container Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '02' then
    with Result do
    begin
      AI:= '02';
      Valor:= Copy(Codigo,3,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of containers';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '10' then
    with Result do
    begin
      AI:= '10';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Batch Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '11' then
    with Result do
    begin
      AI:= '11';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Production Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '13' then
    with Result do
    begin
      AI:= '13';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Packaging Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '15' then
    with Result do
    begin
      AI:= '15';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Sell by Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '17' then
    with Result do
    begin
      AI:= '17';
      Valor:= Copy(Codigo,3,6);
      Tipo:= rtFecha;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Expiration Date';
      Delete(Codigo,1,8);
    end else
  if Copy(Codigo,1,2) = '20' then
    with Result do
    begin
      AI:= '20';
      Valor:= Copy(Codigo,3,2);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Product Variant';
      Delete(Codigo,1,4);
    end else
  if Copy(Codigo,1,2) = '21' then
    with Result do
    begin
      AI:= '21';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Serial Number';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,3) = '310' then
    with Result do
    begin
      AI:= '310';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '311' then
    with Result do
    begin
      AI:= '311';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '312' then
    with Result do
    begin
      AI:= '312';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '313' then
    with Result do
    begin
      AI:= '313';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '314' then
    with Result do
    begin
      AI:= '314';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '315' then
    with Result do
    begin
      AI:= '315';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '316' then
    with Result do
    begin
      AI:= '316';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '320' then
    with Result do
    begin
      AI:= '320';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Product Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '321' then
    with Result do
    begin
      AI:= '321';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '322' then
    with Result do
    begin
      AI:= '322';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '323' then
    with Result do
    begin
      AI:= '323';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '324' then
    with Result do
    begin
      AI:= '324';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '325' then
    with Result do
    begin
      AI:= '325';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '326' then
    with Result do
    begin
      AI:= '326';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '327' then
    with Result do
    begin
      AI:= '327';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '328' then
    with Result do
    begin
      AI:= '328';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '329' then
    with Result do
    begin
      AI:= '329';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Product Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '330' then
    with Result do
    begin
      AI:= '330';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruKg;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '331' then
    with Result do
    begin
      AI:= '331';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '332' then
    with Result do
    begin
      AI:= '332';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '333' then
    with Result do
    begin
      AI:= '333';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros;
      Descripcion:= 'Container Depth/Thickness/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '334' then
    with Result do
    begin
      AI:= '334';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '335' then
    with Result do
    begin
      AI:= '335';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLitros;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '336' then
    with Result do
    begin
      AI:= '336';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruMetros3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '340' then
    with Result do
    begin
      AI:= '340';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruLibras;
      Descripcion:= 'Container Gross Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '341' then
    with Result do
    begin
      AI:= '341';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '342' then
    with Result do
    begin
      AI:= '342';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Length/1st Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '343' then
    with Result do
    begin
      AI:= '343';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Length/1st Dimension in';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '344' then
    with Result do
    begin
      AI:= '344';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Width/Diamater/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '345' then
    with Result do
    begin
      AI:= '345';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '346' then
    with Result do
    begin
      AI:= '346';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Width/Diameter/2nd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '347' then
    with Result do
    begin
      AI:= '347';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '348' then
    with Result do
    begin
      AI:= '348';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '349' then
    with Result do
    begin
      AI:= '349';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas;
      Descripcion:= 'Container Depth/Thickness/Height/3rd Dimension';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '350' then
    with Result do
    begin
      AI:= '350';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '351' then
    with Result do
    begin
      AI:= '351';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '352' then
    with Result do
    begin
      AI:= '352';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Product Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '353' then
    with Result do
    begin
      AI:= '353';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '354' then
    with Result do
    begin
      AI:= '354';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '355' then
    with Result do
    begin
      AI:= '355';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas2;
      Descripcion:= 'Container Area';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '356' then
    with Result do
    begin
      AI:= '356';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruOnzas;
      Descripcion:= 'Net Weight';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '360' then
    with Result do
    begin
      AI:= '360';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '361' then
    with Result do
    begin
      AI:= '361';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '362' then
    with Result do
    begin
      AI:= '362';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruQuarts;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '363' then
    with Result do
    begin
      AI:= '363';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruGalones;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '364' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '365' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '366' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Product Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '367' then
    with Result do
    begin
      AI:= '364';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPulgadas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '368' then
    with Result do
    begin
      AI:= '365';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruPies3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,3) = '369' then
    with Result do
    begin
      AI:= '366';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= StrToInt(Copy(Codigo,4,1));
      Unidades:= ruYardas3;
      Descripcion:= 'Container Gross Volume';
      Delete(Codigo,1,10);
    end else
  if Copy(Codigo,1,2) = '37' then
    with Result do
    begin
      AI:= '37';
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Number of Units Contained';
      Delete(Codigo,1,2);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '400' then
    with Result do
    begin
      AI:= '400';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Customer Purchase Order Number';
      Delete(Codigo,1,3);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '410' then
    with Result do
    begin
      AI:= '410';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Ship To/Deliver To Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '411' then
    with Result do
    begin
      AI:= '411';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Bill To/Invoice Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '412' then
    with Result do
    begin
      AI:= '412';
      Valor:= Copy(Codigo,4,13);
      Tipo:= rtEAN13;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Purchase From Location Code';
      Delete(Codigo,1,16);
    end else
  if Copy(Codigo,1,2) = '8001' then
    with Result do
    begin
      AI:= '8001';
      Valor:= Copy(Codigo,5,14);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Roll Products - Width/Length/Core Diameter';
      Delete(Codigo,1,18);
    end else
  if Copy(Codigo,1,2) = '8004' then
    with Result do
    begin
      AI:= '8004';
      Tipo:= rtTexto;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'UPC/EAN Serial Identification';
      Delete(Codigo,1,4);
      Valor:= EmptyStr;
      while Length(Codigo) > 0 do
      begin
        C:= Codigo[1];
        Delete(Codigo,1,1);
        if C = #$1D then
          break
        else
          Valor:= Valor + C;
      end;
    end else
  if Copy(Codigo,1,2) = '8005' then
    with Result do
    begin
      AI:= '8005';
      Valor:= Copy(Codigo,5,6);
      Tipo:= rtNumero;
      Decimales:= 0;
      Unidades:= ruNinguna;
      Descripcion:= 'Price per Unit of Measure';
      Delete(Codigo,1,10);
    end else
      raise Exception.Create('AI desconocido');
end;
 
function UnidToStr(Unidad: TRegUnidades): String;
begin
  case Unidad of
    ruNinguna: Result:= EmptyStr;
    ruKg: Result:= 'Kilogramos';
    ruMetros: Result:= 'Metros';
    ruMetros2: Result:= 'Metros cuadrados';
    ruMetros3: Result:= 'Metros cubicos';
    ruLitros: Result:= 'Litros';
    ruLibras: Result:= 'Libras';
    ruPulgadas: Result:= 'Pulgadas';
    ruPulgadas2: Result:= 'Pulgadas cuadradas';
    ruPulgadas3: Result:= 'Pulgadas cubicas';
    ruPies: Result:= 'Pies';
    ruPies2: Result:= 'Pies cuadrados';
    ruPies3: Result:= 'Pies cubicos';
    ruYardas: Result:= 'Yardas';
    ruYardas2: Result:= 'Yardas cuadradas';
    ruYardas3: Result:= 'Yardas cubicas';
    ruOnzas: Result:= 'Onzas';
    ruQuarts: Result:= 'Quarts';
    ruGalones: Result:= 'Galones';
  end;
end;
 
 
var
  Str: String;
  i: Integer;
  d: Double;
  Registro: TRegistro;
begin
  while TRUE do
  try
    Readln(Str);
    while Str <> EmptyStr do
    begin
      Writeln;
      Registro:= LeerRegistro(Str);
      Writeln('AI: ' + Registro.AI);
      Writeln('Descr: ' + Registro.Descripcion);
      Writeln('Valor: ' + Registro.Valor);
      case Registro.Tipo of
        rtTexto:  Writeln('Tipo: Texto');
        rtNumero:
          begin
            Writeln('Tipo: Numero');
            Writeln('Decimales: ' + IntToStr(Registro.Decimales));
            Writeln('Unidades: ' + UnidToStr(Registro.Unidades));
            d:= StrToFloat(Registro.Valor);
            i:= Registro.Decimales;
            while i>0 do
            begin
              d:= d / 10;
              dec(i);
            end;
            Writeln('Valor: ' + FloatToStr(d));
          end;
        rtFecha:
          begin
            Writeln('Tipo: Fecha');
            with Registro do
              Writeln('Fecha: ' + Copy(Valor,5,2) + '/' + Copy(Valor,3,2)
                + '/' + Copy(Valor,1,2));
          end;
        rtEAN13:  Writeln('Tipo: EAN13');
      end;
    end;
    Writeln;
  except
    On E: Exception do
    begin
      Writeln;
      Writeln('Error al leer codigo');
      Writeln;
    end;
  end;
end.
*/
end subroutine

public subroutine f_leer_ean128_caja_bulto_sin_parentesis ();string ls_codigo_articulo,ls_descripcion_articulo,ls_codigo_calidad,ls_lote,ls_codigo_pallet,ls_codigo_caja
string ls_ean128,ls_ean13,ls_busqueda,ls_separador_campos = "-"
int    li_calibre

ls_ean128 = this.sle_codbar_caja_bulto.text

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta,ll_row_detalle_actual
string ls_campo_busco

ll_row_detalle_actual = dw_detalle_bultos.getrow()

//Ean13
ls_campo_busco = ""

ll_donde = 1//pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :ls_codigo_articulo, 
			 :ls_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(ls_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :ls_codigo_articulo, 
				 :ls_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	//Calidad
	ls_ean128 = right(ls_ean128,len(ls_ean128)-13)
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		li_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	ls_busqueda = "alm_bultos_lineas_articulo    = '"+ls_codigo_articulo+"' "+&	
					  "and alm_bultos_lineas_calidad = '"+ls_codigo_calidad+"' "+&	
					  "and alm_bultos_lineas_tono    = '"+ls_lote+"' "+&	
					  "and alm_bultos_lineas_calibre = "+string(li_calibre,"#0")+" "+&	
					  "and alm_bultos_lineas_caja    = '"+ls_codigo_caja+"' "
					  
	ll_donde = dw_detalle_bultos.find(ls_busqueda,1,dw_detalle_bultos.rowcount()) 
	
	if ll_donde > 0 then
		dw_detalle_bultos.event rowfocuschanged(ll_donde)
		dw_detalle_bultos.scrolltorow(ll_donde)
		
		event ue_siguiente_objeto()
	else
		//No encuentro esa caja en el bulto
		sle_codbar_caja_bulto.event getfocus()
	end if
else
	//No puedo leer el ean128
	sle_codbar_caja_bulto.event getfocus()
end if
end subroutine

public subroutine f_leer_ean128_caja_bulto_sin_parente_eng ();string ls_codigo_articulo,ls_descripcion_articulo,ls_codigo_calidad,ls_lote,ls_codigo_pallet,ls_codigo_caja
string ls_ean128,ls_ean13,ls_busqueda,ls_separador_campos = "'"
int    li_calibre

ls_ean128 = this.sle_codbar_caja_bulto.text

//Vamos a obtener el ean13 del ean128
long   ll_donde,ll_desde,ll_hasta,ll_row_detalle_actual
string ls_campo_busco

ll_row_detalle_actual = dw_detalle_bultos.getrow()

//Ean13
ls_campo_busco = ""

ll_donde = 1//pos(ls_ean128,ls_campo_busco)

if ll_donde > 0 then
	ll_desde = ll_donde + len(ls_campo_busco)
	ll_hasta = 13
	
	ls_ean13 = Mid(ls_ean128,ll_desde,ll_hasta)
	
	select isnull(articulos.codigo,""), 
			 isnull(articulos.descripcion,"") 
	into   :ls_codigo_articulo, 
			 :ls_descripcion_articulo 
	from   articulos 
	where  articulos.empresa   = :codigo_empresa 
	and    articulos.ean13_sga = :ls_ean13;

	if trim(ls_codigo_articulo) = "" then
		select isnull(articulos.codigo,""), 
				 isnull(articulos.descripcion,"") 
		into   :ls_codigo_articulo, 
				 :ls_descripcion_articulo 
		from   articulos 
		where  articulos.empresa = :codigo_empresa 
		and    articulos.ean13   = :ls_ean13;
	end if
	//Datos de Calidad,Lote,Calibre,Pallet,Caja
	
	//Calidad
	ls_ean128 = right(ls_ean128,len(ls_ean128)-13)
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_calidad = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if			
	
	//Lote
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_lote = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	//Calibre
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		li_calibre = integer(Mid(ls_ean128,ll_desde,ll_hasta))
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if		

	//Pallet
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta = (len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_pallet = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if	

	//Caja
	ls_campo_busco = ""
	
	ll_donde = 1//pos(ls_ean128,ls_campo_busco)
	
	if ll_donde > 0 then
		ll_desde = ll_donde + len(ls_campo_busco)
		ll_hasta = pos(ls_ean128,ls_separador_campos,ll_desde)
		
		if ll_hasta > 0 then
			ll_hasta = ll_hasta - ll_desde
		else
			ll_hasta =(len(ls_ean128) - ll_desde) +1
		end if
		
		ls_codigo_caja = Mid(ls_ean128,ll_desde,ll_hasta)
		
		ls_ean128 = left(ls_ean128,ll_desde -1) + right(ls_ean128,len(ls_ean128) - (ll_desde + ll_hasta))
	end if
		
	ls_busqueda = "alm_bultos_lineas_articulo    = '"+ls_codigo_articulo+"' "+&	
					  "and alm_bultos_lineas_calidad = '"+ls_codigo_calidad+"' "+&	
					  "and alm_bultos_lineas_tono    = '"+ls_lote+"' "+&	
					  "and alm_bultos_lineas_calibre = "+string(li_calibre,"#0")+" "+&	
					  "and alm_bultos_lineas_caja    = '"+ls_codigo_caja+"' "
					  
	ll_donde = dw_detalle_bultos.find(ls_busqueda,1,dw_detalle_bultos.rowcount()) 
	
	if ll_donde > 0 then
		dw_detalle_bultos.event rowfocuschanged(ll_donde)
		dw_detalle_bultos.scrolltorow(ll_donde)
		
		event ue_siguiente_objeto()
	else
		//No encuentro esa caja en el bulto
		sle_codbar_caja_bulto.event getfocus()
	end if
else
	//No puedo leer el ean128
	sle_codbar_caja_bulto.event getfocus()
end if
end subroutine

public subroutine f_orden_carga_asociada_a_bulto ();long li_ordenes_bulto

ib_bulto_asociado_a_orden_de_carga = false
il_id_alm_orden_carga_bulto = 0

SELECT isnull(count(*),0)
INTO   :li_ordenes_bulto
FROM  (  SELECT isnull(venliped.id_alm_orden_carga,0) as id_alm_orden_carga 
			FROM   alm_bultos_lineas 
					 LEFT OUTER JOIN venliped_reservas ON alm_bultos_lineas.id = venliped_reservas.alm_bultos_lineas_id 
					 LEFT OUTER JOIN venliped ON venliped_reservas.empresa = venliped.empresa AND venliped_reservas.anyo = venliped.anyo AND venliped_reservas.pedido = venliped.pedido AND venliped_reservas.linea = venliped.linea, 
					 alm_bultos  
			WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
			AND ( ( alm_bultos.id = :il_id_bulto ) )
			GROUP BY isnull(venliped.id_alm_orden_carga,0) ) AS resultado;

if li_ordenes_bulto = 1 then
	
	SELECT isnull(venliped.id_alm_orden_carga,0) as id_alm_orden_carga 
	INTO   :il_id_alm_orden_carga_bulto
	FROM   alm_bultos_lineas 
			 LEFT OUTER JOIN venliped_reservas ON alm_bultos_lineas.id = venliped_reservas.alm_bultos_lineas_id 
			 LEFT OUTER JOIN venliped ON venliped_reservas.empresa = venliped.empresa AND venliped_reservas.anyo = venliped.anyo AND venliped_reservas.pedido = venliped.pedido AND venliped_reservas.linea = venliped.linea, 
			 alm_bultos  
	WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
	AND ( ( alm_bultos.id = :il_id_bulto ) )
	GROUP BY isnull(venliped.id_alm_orden_carga,0);	

	if il_id_alm_orden_carga_bulto > 0 then ib_bulto_asociado_a_orden_de_carga = true
end if
end subroutine

public subroutine f_orden_preparacion_asociada_a_bulto ();long li_ordenes_bulto

il_id_alm_orden_preparacion_bulto = 0

SELECT isnull(count(*),0)
INTO   :li_ordenes_bulto
FROM  (  SELECT isnull(venliped.id_alm_orden_preparacion,0) as id_alm_orden_preparacion 
			FROM   alm_bultos_lineas 
					 LEFT OUTER JOIN venliped_reservas ON alm_bultos_lineas.id = venliped_reservas.alm_bultos_lineas_id 
					 LEFT OUTER JOIN venliped ON venliped_reservas.empresa = venliped.empresa AND venliped_reservas.anyo = venliped.anyo AND venliped_reservas.pedido = venliped.pedido AND venliped_reservas.linea = venliped.linea, 
					 alm_bultos  
			WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
			AND ( ( alm_bultos.id = :il_id_bulto ) )
			GROUP BY isnull(venliped.id_alm_orden_preparacion,0) ) AS resultado;

if li_ordenes_bulto = 1 then
	
	SELECT isnull(venliped.id_alm_orden_preparacion,0) as id_alm_orden_preparacion 
	INTO   :il_id_alm_orden_preparacion_bulto
	FROM   alm_bultos_lineas 
			 LEFT OUTER JOIN venliped_reservas ON alm_bultos_lineas.id = venliped_reservas.alm_bultos_lineas_id 
			 LEFT OUTER JOIN venliped ON venliped_reservas.empresa = venliped.empresa AND venliped_reservas.anyo = venliped.anyo AND venliped_reservas.pedido = venliped.pedido AND venliped_reservas.linea = venliped.linea, 
			 alm_bultos  
	WHERE ( alm_bultos.id = alm_bultos_lineas.id_alm_bultos ) 
	AND ( ( alm_bultos.id = :il_id_bulto ) )
	GROUP BY isnull(venliped.id_alm_orden_preparacion,0);	
		
	//	AND   ( alm_bultos_lineas.id = :il_alm_bultos_lineas_id )
	
end if
end subroutine

on u_sle_codbar.create
this.p_validar=create p_validar
this.p_bajar=create p_bajar
this.p_subir=create p_subir
this.sle_codbar_ubicacion=create sle_codbar_ubicacion
this.st_lectura_ubicacion=create st_lectura_ubicacion
this.st_lectura_caja_bulto=create st_lectura_caja_bulto
this.sle_codbar_caja_bulto=create sle_codbar_caja_bulto
this.pb_teclado=create pb_teclado
this.dw_detalle_bultos=create dw_detalle_bultos
this.pb_ver_detalle_bulto=create pb_ver_detalle_bulto
this.st_descripcion=create st_descripcion
this.sle_codbar=create sle_codbar
this.st_texto=create st_texto
this.p_codbar=create p_codbar
this.Control[]={this.p_validar,&
this.p_bajar,&
this.p_subir,&
this.sle_codbar_ubicacion,&
this.st_lectura_ubicacion,&
this.st_lectura_caja_bulto,&
this.sle_codbar_caja_bulto,&
this.pb_teclado,&
this.dw_detalle_bultos,&
this.pb_ver_detalle_bulto,&
this.st_descripcion,&
this.sle_codbar,&
this.st_texto,&
this.p_codbar}
end on

on u_sle_codbar.destroy
destroy(this.p_validar)
destroy(this.p_bajar)
destroy(this.p_subir)
destroy(this.sle_codbar_ubicacion)
destroy(this.st_lectura_ubicacion)
destroy(this.st_lectura_caja_bulto)
destroy(this.sle_codbar_caja_bulto)
destroy(this.pb_teclado)
destroy(this.dw_detalle_bultos)
destroy(this.pb_ver_detalle_bulto)
destroy(this.st_descripcion)
destroy(this.sle_codbar)
destroy(this.st_texto)
destroy(this.p_codbar)
end on

event constructor;ll_color_fondo_texto = st_texto.backcolor
ll_color_texto_texto = st_texto.textcolor

p_codbar.enabled = false
st_texto.enabled = false
sle_codbar.enabled = false
pb_ver_detalle_bulto.enabled = false

choose case is_tipo_codigo
	case 'EAN13'
		//st_texto.facename = "EAN-13"
		//il_height_maximo = 2192
		il_height_maximo = 912
		dw_detalle_bultos.dataobject = "dw_u_sle_codbar"
	case 'EAN128'
		//st_texto.facename = "Code 128"
		il_height_maximo = 912
		dw_detalle_bultos.dataobject = "dw_u_sle_codbar2"
	case else
		
end choose

dw_detalle_bultos.modify("datawindow.footer.height = 0")
st_lectura_caja_bulto.visible = false
sle_codbar_caja_bulto.visible = false
p_subir.visible   = false
p_validar.visible = false
p_bajar.visible   = false

st_lectura_ubicacion.visible = false
st_lectura_ubicacion.x       = st_lectura_caja_bulto.x
st_lectura_ubicacion.y       = st_lectura_caja_bulto.y
sle_codbar_ubicacion.visible = false
sle_codbar_ubicacion.x       = sle_codbar_caja_bulto.x
sle_codbar_ubicacion.y       = sle_codbar_caja_bulto.y

dw_detalle_bultos.settransobject(sqlca)

st_texto.text = is_descripcion

//El boton está oculto 25-10-2018 Paco Marin
if ib_permitir_ir_atras then
//	pb_atras.enabled = true
else
//	pb_atras.enabled = false
end if

if ib_mostrar_desplegado then
	height = il_height_maximo
else
	height = il_height_minimo
end if

//El boton está oculto 25-10-2018 Paco Marin
if ib_permitir_desplegar then
	pb_ver_detalle_bulto.enabled = true
else
	pb_ver_detalle_bulto.enabled = false
end if

//pb_atras.visible = false
end event

event destructor;//Sugerencia ubicacion
if il_id_ubicacion_sugerida > 0 then
	update almubimapa_codbar 
	set    almubimapa_codbar.sugerida = 'N' 
	where  almubimapa_codbar.id       = :il_id_ubicacion_sugerida;
	
	if sqlca.sqlcode = 0 then
		commit;
		il_id_ubicacion_sugerida = 0
	else
		rollback;
	end if
end if
end event

type p_validar from picture within u_sle_codbar
integer x = 4338
integer y = 416
integer width = 274
integer height = 224
string picturename = "C:\bmp\Check_24x24.png"
boolean border = true
boolean focusrectangle = false
end type

event clicked;if dw_detalle_bultos.getrow() > 0 then
	if dw_detalle_bultos.getrow() = 1 and dw_detalle_bultos.rowcount() > 1 then
		event modified()		
	end if
	event ue_siguiente_objeto()
end if
end event

type p_bajar from picture within u_sle_codbar
integer x = 4338
integer y = 676
integer width = 274
integer height = 224
string picturename = "C:\bmp\down.bmp"
boolean border = true
boolean focusrectangle = false
end type

event clicked;long ll_donde
if dw_detalle_bultos.getrow() < dw_detalle_bultos.rowcount() then
	ll_donde = dw_detalle_bultos.getrow()
	ll_donde ++
	dw_detalle_bultos.event rowfocuschanged(ll_donde)
	dw_detalle_bultos.scrolltorow(ll_donde)
end if
end event

type p_subir from picture within u_sle_codbar
integer x = 4338
integer y = 160
integer width = 274
integer height = 224
string picturename = "C:\bmp\up.bmp"
boolean border = true
boolean focusrectangle = false
end type

event clicked;long ll_donde
if dw_detalle_bultos.getrow() > 1 then
	ll_donde = dw_detalle_bultos.getrow()
	ll_donde --
	dw_detalle_bultos.event rowfocuschanged(ll_donde)
	dw_detalle_bultos.scrolltorow(ll_donde)
end if
end event

type sle_codbar_ubicacion from singlelineedit within u_sle_codbar
event keydown pbm_keydown
integer x = 1810
integer y = 588
integer width = 2514
integer height = 144
integer taborder = 50
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event keydown;if KeyDown(KeyEnter!) then
	//Comprobamos el valor del codigo de barras y lanzamos el evento modified 
	this.event modified()
end if
end event

event getfocus;this.SelectText(1,len(this.text))
end event

event modified;
f_leer_ubicacion_para_bulto()
end event

type st_lectura_ubicacion from statictext within u_sle_codbar
integer x = 9
integer y = 588
integer width = 1618
integer height = 144
integer textsize = -20
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Leer ubicación"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_lectura_caja_bulto from statictext within u_sle_codbar
integer x = 9
integer y = 756
integer width = 1618
integer height = 144
integer textsize = -20
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Leer etiqueta caja"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type sle_codbar_caja_bulto from singlelineedit within u_sle_codbar
event keydown pbm_keydown
integer x = 1810
integer y = 756
integer width = 2514
integer height = 144
integer taborder = 40
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event keydown;if KeyDown(KeyEnter!) then
	//Comprobamos el valor del codigo de barras y lanzamos el evento modified 
	this.event modified()
end if
end event

event getfocus;this.SelectText(1,len(this.text))
end event

event modified;string ls_prefijo

ls_prefijo = left(this.text,1)		
choose case ls_prefijo
	case "("
		f_leer_ean128_caja_bulto()
	case ")"
		f_leer_ean128_eng_caja_bulto()
	case "["
		f_leer_ean128_prov_caja_bulto()		
	case "`"
		f_leer_ean128_prov_eng_caja_bulto()
	case else
		if pos(this.text,'-') > 0 then
			f_leer_ean128_caja_bulto_sin_parentesis()
		else
			f_leer_ean128_caja_bulto_sin_parente_eng()
		end if
end choose
end event

type pb_teclado from picturebutton within u_sle_codbar
integer x = 1641
integer width = 165
integer height = 144
integer taborder = 30
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\bmp\RF\Auto-Type.png"
string disabledname = "C:\bmp\RF\Auto-Type_dis.png"
end type

event clicked;//shellexecutea(Handle(This),"open","C:\Tencer_PB12\osk.exe",0,0,1)
//gf_ejecutar('C:\Windows\System32\osk.exe')
//gf_ejecutar('C:\Tencer_PB12\osk.exe')
//gf_ejecutar("C:\Windows\WinSxS\amd64_microsoft-windows-osk_31bf3856ad364e35_10.0.17134.376_none_8c47b691b018d9c4\osk.exe")
gf_ejecutar("C:\Windows\WinSxS\amd64_microsoft-windows-osk_31bf3856ad364e35_10.0.17763.1_none_9b82bd51b2181d7d\osk.exe")
parent.event getfocus()
end event

type dw_detalle_bultos from datawindow within u_sle_codbar
integer x = 5
integer y = 148
integer width = 4617
integer height = 760
integer taborder = 30
string title = "none"
string dataobject = "dw_u_sle_codbar"
boolean livescroll = true
end type

event rowfocuschanged;this.selectrow(0,false)

if this.dataobject = "dw_u_sle_codbar" then
	if currentrow > 0 and currentrow <= rowcount() then
		
		this.selectrow(currentrow,true)
		//this.setrow(currentrow)
		ii_indice_lineas_bulto = currentrow
		
		if not(ib_insertando_row) then
		
			il_id_ubicacion = this.object.almubimapa_codbar_id[currentrow]
			is_almacen      = this.object.almubimapa_codbar_almacen[currentrow]
			is_zona         = this.object.almubimapa_codbar_zona[currentrow]
			ii_fila         = this.object.almubimapa_codbar_fila[currentrow]
			ii_altura       = this.object.almubimapa_codbar_altura[currentrow]
		
			f_cargar_str_almubimapa_codbar(il_id_ubicacion,istr_almubimapa_codbar)
			f_inicializar_str_almubimapa_codbar(istr_almubimapa_codbar)
			
			if istr_almubimapa_codbar.id_alm_bultos > 0 then
				ib_ubicacion_con_bulto_asociado = true	
			else
				ib_ubicacion_con_bulto_asociado = false
			end if
			
			if istr_almubimapa_codbar.gestionar_en_piezas = 'S' then
				ib_ubicacion_gestionada_en_piezas = true
			else
				ib_ubicacion_gestionada_en_piezas = false
			end if
			
			if istr_almubimapa_codbar.permitir_reservas = 'N' then
				ib_ubicacion_permite_reservas = false
			else
				ib_ubicacion_permite_reservas = true
			end if			
		
			il_id_bulto             = this.object.alm_bultos_id[currentrow]
			il_alm_bultos_lineas_id = this.object.alm_bultos_lineas_id[currentrow]
			
			ii_lineas_bulto         = integer(this.describe('evaluate("sum(if (alm_bultos_id = '+string(il_id_bulto)+',1,0) for all)",1)'))
			
			is_codigo_articulo      = this.object.alm_bultos_lineas_articulo[currentrow]
			is_descripcion_articulo = this.object.articulos_descripcion[currentrow]
			is_codigo_caja          = this.object.alm_bultos_lineas_caja[currentrow]
			is_codigo_pallet        = this.object.alm_bultos_tipo_pallet[currentrow]
			is_codigo_calidad       = this.object.alm_bultos_lineas_calidad[currentrow]
			is_lote                 = this.object.alm_bultos_lineas_tono[currentrow]
			ii_calibre              = this.object.alm_bultos_lineas_calibre[currentrow]
			il_piezas               = this.object.alm_bultos_lineas_cantidad[currentrow]
			
			ii_anyo_orden_carga     = this.object.alm_bultos_anyo_orden_carga[currentrow]
			is_orden_carga          = this.object.alm_bultos_codigo_orden_carga[currentrow]
			il_linea_orden_carga    = this.object.alm_bultos_lineas_linea_orden_carga[currentrow]
			
			f_cargar_str_articulos(codigo_empresa,is_codigo_articulo,istr_articulos)
			
			f_cargar_str_almartcajas(codigo_empresa,is_codigo_articulo,is_codigo_caja,istr_almartcajas)
			
			f_cargar_str_palarticulo(codigo_empresa,is_codigo_articulo,is_codigo_pallet,is_codigo_caja,istr_palarticulo)		
			
			f_calculo_disponible_linea()
			
			f_orden_carga_asociada_a_bulto()
			
			f_orden_preparacion_asociada_a_bulto()
			
			if ib_lanzar_modified then
				parent.event modified()		
			end if
		end if
	end if
else
	parent.event modified()	
end if
end event

event retrieveend;if rowcount > 0 then
	this.event rowfocuschanged(1)
end if
end event

type pb_ver_detalle_bulto from picturebutton within u_sle_codbar
boolean visible = false
integer x = 4325
integer y = 8
integer width = 146
integer height = 128
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "EditDataGrid!"
alignment htextalign = left!
end type

event clicked;if parent.height = il_height_minimo then
	parent.height = il_height_maximo
else
	parent.height = il_height_minimo
end if
end event

type st_descripcion from statictext within u_sle_codbar
boolean visible = false
integer x = 5
integer y = 156
integer width = 4626
integer height = 144
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;sle_codbar.setfocus()
end event

type sle_codbar from singlelineedit within u_sle_codbar
event keydown pbm_keydown
event clicked pbm_bnclicked
integer x = 1810
integer width = 2514
integer height = 144
integer taborder = 10
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event keydown;if KeyDown(KeyEnter!) then
	//Comprobamos el valor del codigo de barras y lanzamos el evento modified 
	choose case is_tipo_codigo
		case 'EAN13'
			if len(this.text) <> 13 then
				this.text = ''
			end if			
		case 'EAN128'
			
		case else
			
	end choose
	this.event modified()
end if
end event

event clicked;sle_codbar.event getfocus()
end event

event modified;string ls_prefijo,ls_ean13
int    li_ubicaciones,li_bultos

choose case is_tipo_codigo
	case 'EAN13'
		ls_ean13   = this.text
		ls_prefijo = left(this.text,2)		

		//Cambiar esto cuando detectemos que ya no hay bultos que empiecen por 21
		select isnull(count(*),0)
		into   :li_ubicaciones
		from   almubimapa_codbar
		where  almubimapa_codbar.empresa = :codigo_empresa 
		and    almubimapa_codbar.ean13   = :ls_ean13;
		
		if li_ubicaciones > 0 then
			f_leer_ubicacion()
		else
			select isnull(count(*),0)
			into   :li_bultos
			from   alm_bultos
			where  alm_bultos.empresa = :codigo_empresa 
			and    alm_bultos.ean13   = :ls_ean13;
			
			if li_bultos > 0 then
				f_leer_bulto()
			else
				f_leer_articulo()
			end if
			
		end if
		/*
		choose case ls_prefijo
			case '20','21','22','23','24'
				//Ubicacion
				f_leer_ubicacion()
			case '25','26','27','28'
				//Bulto
				f_leer_bulto()
			case else
				//Articulo
				f_leer_articulo()
		end choose
		*/
	case 'EAN128'
		ls_prefijo = left(this.text,1)		
		choose case ls_prefijo
			case "("
				f_leer_ean128()
			case ")"
				f_leer_ean128_eng()
			case "["
				f_leer_ean128_prov()				
			case "`"
				f_leer_ean128_prov_eng()
			case else
				if pos(this.text,'-') > 0 then
					f_leer_ean128_sin_parentesis()
				else
					f_leer_ean128_sin_parentesis_eng()
				end if
		end choose
		
	case else	
end choose

/* Lo quito el 05-11-2020 Paco Marin
parent.event modified()
*/

/*
SingleLineEdit sle_which
CommandButton cb_which
string ls_text_valueDrag
Object which_control
which_control = DraggedObject()
CHOOSE CASE TypeOf(which_control)
	CASE CommandButton!    
		cb_which = which_control    
		ls_text_value = cb_which.Text
	CASE SingleLineEdit!    
		sle_which = which_control    
		ls_text_value = sle_which.Text
END CHOOSE

if isvalid(ipo_siguiente_objeto) then
	typeof
	ipo_siguiente_objeto.SetFocus()
end if
*/
/*
//this.event getfocus()
//
//GraphicObject object 
Message.Processed = true 
Message.ReturnValue = 0 
//object = GetFocus() 
Send ( handle ( this ), 256, 9, long ( 0, 0 ) ) 
*/
end event

event getfocus;this.SelectText(1,len(this.text))

sle_codbar_caja_bulto.text = ""
end event

type st_texto from statictext within u_sle_codbar
integer x = 9
integer width = 1618
integer height = 144
integer textsize = -20
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24011603
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event clicked;if ib_sugiriendo_ubicacion then
	if is_filto_ubicaciones_sugeridas_descartadas = "" then
		is_filto_ubicaciones_sugeridas_descartadas = string(il_id_ubicacion_sugerida)
	else
		is_filto_ubicaciones_sugeridas_descartadas += ","+string(il_id_ubicacion_sugerida)
	end if
	f_sugerir_ubicacion_destino(iu_sle_codbar_ubicacion_sugiero)
end if
sle_codbar.setfocus()	
end event

type p_codbar from picture within u_sle_codbar
integer width = 165
integer height = 144
string picturename = "C:\bmp\Bar Code.gif"
boolean focusrectangle = false
end type

event clicked;sle_codbar.setfocus()
end event

