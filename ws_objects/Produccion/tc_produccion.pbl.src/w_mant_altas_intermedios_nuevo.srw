$PBExportHeader$w_mant_altas_intermedios_nuevo.srw
forward
global type w_mant_altas_intermedios_nuevo from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_altas_intermedios_nuevo
end type
type dw_listado from datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_codestadistico from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_caja_articulo from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_paletizado from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_calidad_altas from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type cb_duplicar from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_3 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_1 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type dw_listado_ficha from datawindow within w_mant_altas_intermedios_nuevo
end type
type cb_añadir_ver from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_eliminar_ver from commandbutton within w_mant_altas_intermedios_nuevo
end type
type st_2 from statictext within w_mant_altas_intermedios_nuevo
end type
type cb_añadir from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_eliminar from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_intercalar from commandbutton within w_mant_altas_intermedios_nuevo
end type
type st_3 from statictext within w_mant_altas_intermedios_nuevo
end type
type dw_aplicaciones from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type cb_añadir2 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_eliminar2 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_intercalar2 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type dw_escandallo from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type cb_añadir3 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type r_2 from rectangle within w_mant_altas_intermedios_nuevo
end type
type r_1 from rectangle within w_mant_altas_intermedios_nuevo
end type
type r_3 from rectangle within w_mant_altas_intermedios_nuevo
end type
type st_50 from statictext within w_mant_altas_intermedios_nuevo
end type
type cb_duplicar_todo from commandbutton within w_mant_altas_intermedios_nuevo
end type
type dw_versiones from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type pb_4 from upb_imprimir within w_mant_altas_intermedios_nuevo
end type
type pb_anterior from picturebutton within w_mant_altas_intermedios_nuevo
end type
type pb_siguiente from picturebutton within w_mant_altas_intermedios_nuevo
end type
type st_mensaje from statictext within w_mant_altas_intermedios_nuevo
end type
type pb_1 from picturebutton within w_mant_altas_intermedios_nuevo
end type
type st_6 from statictext within w_mant_altas_intermedios_nuevo
end type
type dw_operaciones from u_datawindow within w_mant_altas_intermedios_nuevo
end type
type sle_busqueda from singlelineedit within w_mant_altas_intermedios_nuevo
end type
type tv_escandallo from treeview within w_mant_altas_intermedios_nuevo
end type
type cb_2 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type cb_4 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type st_aplicaciones from statictext within w_mant_altas_intermedios_nuevo
end type
type dw_articulos_ant from datawindow within w_mant_altas_intermedios_nuevo
end type
type pb_bloquear_1 from picturebutton within w_mant_altas_intermedios_nuevo
end type
type pb_bloquear_estructura from picturebutton within w_mant_altas_intermedios_nuevo
end type
type pb_2 from picturebutton within w_mant_altas_intermedios_nuevo
end type
type pb_3 from picturebutton within w_mant_altas_intermedios_nuevo
end type
type dw_imagen from u_dw_imagen within w_mant_altas_intermedios_nuevo
end type
type cb_eliminar3 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type st_5 from statictext within w_mant_altas_intermedios_nuevo
end type
type pb_archivos_modelo from picturebutton within w_mant_altas_intermedios_nuevo
end type
type st_7 from statictext within w_mant_altas_intermedios_nuevo
end type
type cb_6 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type dw_listado_ficha2 from datawindow within w_mant_altas_intermedios_nuevo
end type
type cb_7 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type dw_articulo_inicial from u_dw within w_mant_altas_intermedios_nuevo
end type
type dw_articulo_final from u_dw within w_mant_altas_intermedios_nuevo
end type
type dw_referencias from u_dw within w_mant_altas_intermedios_nuevo
end type
type cb_5 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type p_imagen from picture within w_mant_altas_intermedios_nuevo
end type
type cb_8 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type st_contador from statictext within w_mant_altas_intermedios_nuevo
end type
type cb_copiar_parametros from commandbutton within w_mant_altas_intermedios_nuevo
end type
type dw_cajas from datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_ruta_duplicar from datawindow within w_mant_altas_intermedios_nuevo
end type
type mle_observaciones from multilineedit within w_mant_altas_intermedios_nuevo
end type
type dw_imagenes_modelo from datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_articulos_post from datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_2 from datawindow within w_mant_altas_intermedios_nuevo
end type
type cb_9 from commandbutton within w_mant_altas_intermedios_nuevo
end type
type dw_imprimir_seleccionados from datawindow within w_mant_altas_intermedios_nuevo
end type
type dw_listado_ficha3 from datawindow within w_mant_altas_intermedios_nuevo
end type
end forward

global type w_mant_altas_intermedios_nuevo from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 7063
integer height = 4052
string title = "Mantenimiento de Altas de Artículos Semielaborados"
pb_calculadora pb_calculadora
dw_listado dw_listado
dw_codestadistico dw_codestadistico
dw_caja_articulo dw_caja_articulo
dw_paletizado dw_paletizado
dw_calidad_altas dw_calidad_altas
cb_duplicar cb_duplicar
cb_3 cb_3
cb_1 cb_1
dw_listado_ficha dw_listado_ficha
cb_añadir_ver cb_añadir_ver
cb_eliminar_ver cb_eliminar_ver
st_2 st_2
cb_añadir cb_añadir
cb_eliminar cb_eliminar
cb_intercalar cb_intercalar
st_3 st_3
dw_aplicaciones dw_aplicaciones
cb_añadir2 cb_añadir2
cb_eliminar2 cb_eliminar2
cb_intercalar2 cb_intercalar2
dw_escandallo dw_escandallo
cb_añadir3 cb_añadir3
r_2 r_2
r_1 r_1
r_3 r_3
st_50 st_50
cb_duplicar_todo cb_duplicar_todo
dw_versiones dw_versiones
pb_4 pb_4
pb_anterior pb_anterior
pb_siguiente pb_siguiente
st_mensaje st_mensaje
pb_1 pb_1
st_6 st_6
dw_operaciones dw_operaciones
sle_busqueda sle_busqueda
tv_escandallo tv_escandallo
cb_2 cb_2
cb_4 cb_4
st_aplicaciones st_aplicaciones
dw_articulos_ant dw_articulos_ant
pb_bloquear_1 pb_bloquear_1
pb_bloquear_estructura pb_bloquear_estructura
pb_2 pb_2
pb_3 pb_3
dw_imagen dw_imagen
cb_eliminar3 cb_eliminar3
st_5 st_5
pb_archivos_modelo pb_archivos_modelo
st_7 st_7
cb_6 cb_6
dw_listado_ficha2 dw_listado_ficha2
cb_7 cb_7
dw_articulo_inicial dw_articulo_inicial
dw_articulo_final dw_articulo_final
dw_referencias dw_referencias
cb_5 cb_5
p_imagen p_imagen
cb_8 cb_8
st_contador st_contador
cb_copiar_parametros cb_copiar_parametros
dw_cajas dw_cajas
dw_ruta_duplicar dw_ruta_duplicar
mle_observaciones mle_observaciones
dw_imagenes_modelo dw_imagenes_modelo
dw_articulos_post dw_articulos_post
dw_2 dw_2
cb_9 cb_9
dw_imprimir_seleccionados dw_imprimir_seleccionados
dw_listado_ficha3 dw_listado_ficha3
end type
global w_mant_altas_intermedios_nuevo w_mant_altas_intermedios_nuevo

type variables
Boolean activo_escandallo = true

end variables

forward prototypes
public subroutine f_valorar_stock ()
public subroutine f_calculos_caja ()
public function boolean f_duplicar_estructura (string padre, string padre_c)
public subroutine f_contraer_tv (long hijo)
public subroutine fr_bloquear (string codigo, integer accion)
public subroutine fr_anular (string codigo, integer accion)
public function boolean f_cargar_imagen_pieza ()
public function string f_duplicar_operaciones (string empresa, string articulo_origen, string articulo_destino, string ruta_origen, string ruta_destino, transaction transaccion)
public function string fr_duplicar_con_estructura_nueva (string articulo_a_duplicar, string articulo_origen_escandallo, string version_origen_escandallo, string aprovecha_origen_escandallo, decimal factor_origen_escandallo, transaction transaccion, string descripcion_ver_origen_escandallo, string observaciones_origen_escandallo, string tipo_ver_origen_escandallo, boolean bases)
public subroutine f_cambiar_nombres ()
public function string fr_duplicar_estructura_dw (string articulo_a_duplicar, string articulo_origen_escandallo, string version_origen_escandallo, string aprovecha_origen_escandallo, decimal factor_origen_escandallo, transaction arg_trans, string descripcion_ver_origen_escandallo, string observaciones_origen_escandallo, string tipo_ver_origen_escandallo, long fila)
public function integer fr_cambio_parametros_base (str_aux_parametros_base parametros, string articulo)
end prototypes

public subroutine f_valorar_stock ();int rtn = 1
string v_fecha_tar_activa, v_fecha_alta
string v_calidad, v_formato, v_g2, v_g3, v_familia, v_modelo, v_activo, v_listar, v_usuario
string des_articulo, articulo_calidad, v_articulo, v_uso
dec{2} v_precio, v_ancho, v_largo, v_precio_base_c_r, v_valor_base_c_r, v_precio_base_l
dec{2} v_valor_base_l, v_precio_bizcocho, v_valor_bizcocho, v_valor_acabado, v_precio_acabado
dec  fila_actual
dec total_reg

// Extraemos parametros del código estadístico
select g2, g3
into :v_g2, :v_g3
from art_codestadistico
where empresa = :codigo_empresa
and codigo = :sle_valor.text;

select uso , formato, familia
into :v_uso, :v_formato, :v_familia
from articulos 
where codigo = :sle_valor.text
and empresa = :codigo_empresa;



if v_uso = '2' then
	messagebox(" Aviso","Los artículos Intermedios los valorará el dpto. comercial", StopSign!)
	return
end if


select count(*) 
into   :total_reg
from venlintarifas
where articulo = :sle_valor.text
and 	tarifa = "5"
and empresa = :codigo_empresa;

select activa 
into :v_fecha_tar_activa
from ventarifas
where codigo = "5"
and empresa = :codigo_empresa;

v_calidad = "1"

v_usuario = nombre_usuario

select ancho, largo
into :v_ancho, :v_largo
from formatos
where empresa = :codigo_empresa
and   codigo = :v_formato;

select precio_base_c_r, valor_base_c_r, precio_base_l, valor_base_l, precio_bizcocho, valor_bizcocho, valor_acabado
into :v_precio_base_c_r, :v_valor_base_c_r, :v_precio_base_l, :v_valor_base_l, :v_precio_bizcocho, 
     :v_valor_bizcocho, :v_valor_acabado
from valoracionbases
where empresa = :codigo_empresa
and codigo = "1";

if (v_g2 = "B") and ((v_g3 = "C") or (v_g3 = "R")) then
	v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_c_r * (1 - v_valor_base_c_r/100))
elseif (v_g2 = "B") and ((v_g3 = "L") or (v_g3 = "P"))then
	v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_l * (1 - v_valor_base_l/100))
elseif (v_g2 = "Z") then
	v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_bizcocho * (1 - v_valor_bizcocho/100))
else
	select precio 
	into   :v_precio_acabado
	from venlintarifas
	where articulo = :sle_valor.text
	and tarifa <> "5";
	v_precio = v_precio_acabado * (1 - v_valor_acabado/100)
end if

select codigo,descripcion
into :v_articulo,:des_articulo
from articulos
where empresa = :codigo_empresa
and codigo = :sle_valor.text;


v_fecha_alta = String(Today(), "dd/mm/yy hh:mm:ss")

articulo_calidad = v_articulo + right("00"+v_calidad,2) 

if total_reg = 0 then
	insert into venlintarifas
	(empresa, tarifa, fecha, articulo, calidad, precio, falta, montajeartcal, familia, formato, 
	activo, listar, usuario, descripcion, excepcion, tipo_linea)
	values (:codigo_empresa, "5", :v_fecha_tar_activa, :sle_valor.text, :v_calidad, :v_precio, :v_fecha_alta,
				:articulo_calidad, :v_familia, :v_formato, "S", "S", :v_usuario, :des_articulo, "N", "2") using sqlca;
	if sqlca.sqlcode <> 0 then rtn = -1
else
	if MessageBox("Atención", "La tarifa valorada ya existe. ¿Desea actualizarla?.", Question!, YesNo!, 2) = 1 then
		update venlintarifas
		set fecha = :v_fecha_tar_activa, precio = :v_precio
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text
		and tarifa  = "5" using sqlca;
		if sqlca.sqlcode <> 0 then rtn = -1
	end if
end if

if rtn = 1 then 
	commit using sqlca;
else 
	rollback using sqlca;
	messagebox("Error", "Error grabando")
end if

end subroutine

public subroutine f_calculos_caja ();Dec{3} peso_caja,peso_envase,peso_piezas,metros_caja,metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho
String cod_formato, var_caja

select piezascaja, caja
into :var_piezas, :var_caja
from almartcajas
where empresa = :codigo_empresa
and articulo = :sle_valor.text
and pordefecto = 'S';


var_peso_pieza = dw_1.object.pesopieza[dw_1.Getrow()]
peso_piezas = var_peso_pieza  * var_piezas
peso_envase     = f_peso_envase(codigo_empresa, var_caja)
peso_caja     = peso_envase + peso_piezas

cod_formato = f_formato_articulo (codigo_empresa,sle_valor.text)

var_largo = f_largo_formato(codigo_empresa,cod_formato)
var_ancho = f_ancho_formato(codigo_empresa,cod_formato)

metros_caja  = (var_piezas * var_largo*var_ancho)/10000
metrosl_caja = (var_piezas * var_largo)/100

update almartcajas 
set 	pesocaja = :peso_caja, 
		metroscaja= :metros_caja,
		metros_reales = :metros_caja,
		metroslcaja = :metrosl_caja		
where empresa = :codigo_empresa
and articulo = :sle_valor.text
and caja = :var_caja using SQLCA;

if SQLCA.SQLCode <> -1 then
	commit;
else
	rollback;
	messagebox("Error"," No se pueden insertar los cáculos de la caja. ")
end if


end subroutine

public function boolean f_duplicar_estructura (string padre, string padre_c);long i, j, m, total_regs
string consulta_anteriores, v_uso
datastore registros
string hijo[25], hijo_c[25]


consulta_anteriores = 	" select articulo_ant "+&
								" from art_escandallo "+&
								" where empresa = '"+codigo_empresa+"' "+&
								" and articulo = '"+padre+"' "
								
f_cargar_cursor_nuevo (consulta_anteriores, registros)
total_regs = registros.rowcount()
for m = 1 to total_regs
	hijo[m] = registros.object.articulo_ant[m]
next

for j = 1 to total_regs
	if hijo[j] <> '0'	then
		select uso
		into :v_uso
		from articulos
		where empresa = :codigo_empresa
		and codigo = :hijo[j];
		
		if v_uso <> '1' then
			hijo_c[j] =  string(f_buscar_codigo_Articulo())
			f_duplicar_estructura (hijo[j], hijo_c[j])
		else
			hijo_c[j] = hijo[j]
		end if
	else
		hijo_c[j] = '0'
	end if
	
	// f_enlazar escandallo (padre_c[i], hijo_c[j]
	messagebox ("Enlazando", "PADRE: "+padre_c+ " HIJO: "+hijo_c[j])
next

destroy registros
return true


end function

public subroutine f_contraer_tv (long hijo);Long hijo_sig

do while (hijo <> -1)
	tv_escandallo.collapseItem(hijo)
	hijo_sig = tv_escandallo.FindItem(ChildTreeItem! , hijo)
	f_contraer_tv(hijo_sig)
	hijo	= 	tv_escandallo.FindItem(NextTreeItem!, hijo)
loop
end subroutine

public subroutine fr_bloquear (string codigo, integer accion);String bloqueado, codigo_sig, codigo_bloqueado, sel, uso
Int i
Datastore escandallo

if accion = 1 then
	bloqueado = 'S'
else
	bloqueado = 'N'
end if

SELECT uso INTO :uso FROM articulos WHERE codigo = :codigo;

//Las bases no se bloquean
if uso <> "1" and not ftc_articulo_base(codigo) then
	update articulos
	set bloqueado = :bloqueado
	where empresa = :codigo_empresa
	and codigo = :codigo;
end if

sel = "SELECT articulo_ant, articulo FROM art_escandallo WHERE empresa = '"+codigo_empresa+"' AND articulo = '"+codigo+"' "
f_cargar_cursor_trans (SQLCA,  sel,  escandallo)

For i = 1 To escandallo.RowCount()
	codigo_sig = trim(escandallo.object.articulo_ant[i])
	//Condición de parada
	if not isnull(codigo_sig) and codigo_sig <> '' and codigo_sig <> '0' then
		fr_bloquear(codigo_sig,accion)
	end if
Next

Destroy escandallo
end subroutine

public subroutine fr_anular (string codigo, integer accion);String codigo_sig, codigo_bloqueado, sel, uso, descripcion
Datetime fecha_anulado
Int i, posicion
Datastore escandallo
int rtn

SELECT
	uso, descripcion INTO :uso, :descripcion
FROM articulos 
WHERE codigo = :codigo 
using sqlca;

if accion = 1 then
	fecha_anulado = Datetime(Today(),Now())
	descripcion = trim(descripcion)
	if pos(descripcion,"NULO") <> 1 then
		descripcion = "NULO "+descripcion		
	end if
else
	setnull(fecha_anulado)
	descripcion = trim(descripcion)
	posicion = pos(descripcion,"NULO")
	if posicion = 1 then
		descripcion = trim(mid(descripcion, posicion+4))
	end if
end if

//Las bases no se bloquean
if uso <> "1" and not ftc_articulo_base(codigo) then
	update articulos
	set 
			fecha_anulado = :fecha_anulado,
			descripcion = :descripcion
	where empresa = :codigo_empresa
			and codigo = :codigo 
	using sqlca;
	
	commit using sqlca;
end if

sel = "SELECT articulo_ant, articulo FROM art_escandallo WHERE empresa = '"+codigo_empresa+"' AND articulo = '"+codigo+"' "
f_cargar_cursor_trans (SQLCA,  sel,  escandallo)

For i = 1 To escandallo.RowCount()
	codigo_sig = trim(escandallo.object.articulo_ant[i])
	//Condición de parada
	if not isnull(codigo_sig) and codigo_sig <> '' and codigo_sig <> '0' then
		fr_anular(codigo_sig,accion)
	end if
Next

Destroy escandallo
end subroutine

public function boolean f_cargar_imagen_pieza ();//CON RUTAS
string ruta, tamanyo, articulo, base
Long min_codigo_archivo
Boolean res = false

SELECT tamanyo INTO :tamanyo FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = 5;

dw_imagen.visible = false // para evitar efectos raros en pantalla.

articulo = String(sle_valor.text)
ruta = ftc_imagen_articulo_ruta("5", articulo)

if ruta <> "" then
	dw_imagen.Object.datawindow.picture.File =  ruta
	dw_imagen.visible = true
	res = true
else
	if ftc_articulo_base2(articulo, base) then
		ruta = ftc_imagen_articulo_ruta("5", base)
		if ruta <> "" then
			dw_imagen.Object.datawindow.picture.File = ruta
			dw_imagen.visible = true
			res = true
		else
			res = false
			dw_imagen.visible = false
		end if
	else
		res = false
		dw_imagen.visible = false
	end if
end if

return res
end function

public function string f_duplicar_operaciones (string empresa, string articulo_origen, string articulo_destino, string ruta_origen, string ruta_destino, transaction transaccion);String v_version, articulo_a_duplicar, v_codigo, v_version_destino
String sel
Long i
String v_operacion, v_tipo_operacion, v_orden, v_formato_op, v_juegopantallas, v_coste, v_orientacion, operacion, ver
String v_operacion_apl, v_contadoraplicacion, v_pantalla, v_formula, v_tipoaplicacion, v_orden_apl, v_boquilla, v_ciclo, v_temp_sup, v_temp_inf, v_cortes, v_discos
dec v_gramaje, v_gram_7x20, v_densidad, v_viscosidad, v_piezas_fila
Dec v_factor, coste_mp_operacion
int v_numaplicaciones
String v_archivo_disenyo_tipomaquina_disenyo, v_archivo_disenyo_codigo, v_archivo_disenyo_prueba

Datastore operaciones, aplicaciones, regs_coste

articulo_a_duplicar = articulo_origen
v_codigo = articulo_destino
v_version = ruta_origen
v_version_destino = ruta_destino

sel = "select operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila "+&
		" from art_ver_operaciones "+&
		" where empresa = "+empresa+&
		" and articulo = "+articulo_a_duplicar+&
		" and version = "+v_version;
		
f_cargar_cursor_trans(transaccion, sel, operaciones)

for i = 1 to operaciones.rowcount() 
	v_operacion = operaciones.object.operacion[i]
	v_tipo_operacion = operaciones.object.tipo_operacion[i]
	v_orden = operaciones.object.orden[i]
	v_formato_op = operaciones.object.formato[i]
	v_factor = 1
	v_juegopantallas = operaciones.object.juegopantallas[i]
	v_numaplicaciones = operaciones.object.numaplicaciones[i]
	v_coste = operaciones.object.coste[i]
	v_orientacion = operaciones.object.orientacion[i]
	v_piezas_fila =operaciones.object.piezas_fila[i]
	
	insert into
		art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila)
	values
		(:empresa, :v_codigo, :v_version_destino, :v_operacion, :v_tipo_operacion, :v_orden	, :v_formato_op,  :v_factor, 
		:v_juegopantallas, :v_numaplicaciones, :v_coste, :v_orientacion, :v_piezas_fila) 
	using transaccion;
	
	if transaccion.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_versiones "+ transaccion.SQLErrText) 
		return "-1"
	end if
next



sel = " select operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, orden, densidad, viscosidad, "+&
		" boquilla, ciclo, temp_sup, temp_inf, cortes, discos, archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba "+&
		" from art_ver_op_aplicaciones "+&
		" where empresa = "+empresa+&
		" and articulo = "+articulo_a_duplicar+&
		" and version = "+v_version;
		
f_cargar_cursor_trans(transaccion, sel, aplicaciones)

for i = 1 to aplicaciones.rowcount()
	v_operacion_apl = aplicaciones.object.operacion[i]
	v_contadoraplicacion = aplicaciones.object.contadoraplicacion[i]
	v_pantalla = aplicaciones.object.pantalla[i]
	v_formula = aplicaciones.object.formula[i]
	v_tipoaplicacion = aplicaciones.object.tipoaplicacion[i]
	v_orden_apl = aplicaciones.object.orden[i]
	v_boquilla = aplicaciones.object.boquilla[i]
	v_ciclo = aplicaciones.object.ciclo[i]
	v_temp_sup = aplicaciones.object.temp_sup[i]
	v_temp_inf = aplicaciones.object.temp_inf[i]
	v_cortes = aplicaciones.object.cortes[i]
	v_discos = aplicaciones.object.discos[i]
	v_gramaje = aplicaciones.object.gramaje[i]
	v_gram_7x20 = aplicaciones.object.gram_7x20[i]
	v_densidad = aplicaciones.object.densidad[i]
	v_viscosidad = aplicaciones.object.viscosidad[i]
	v_archivo_disenyo_tipomaquina_disenyo = aplicaciones.object.archivo_disenyo_tipomaquina_disenyo[i]
	v_archivo_disenyo_codigo = aplicaciones.object.archivo_disenyo_codigo[i]
	v_archivo_disenyo_prueba = aplicaciones.object.archivo_disenyo_prueba[i]

	insert into
		art_ver_op_aplicaciones (empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, 
										orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, 
										archivo_disenyo_prueba)
	values
		(:empresa, :v_codigo, :v_version_destino, :v_operacion_apl, :v_contadoraplicacion, :v_pantalla, :v_formula, :v_gramaje, :v_gram_7x20, :v_tipoaplicacion,
		:v_orden_apl, :v_densidad, :v_viscosidad, :v_boquilla, :v_ciclo, :v_temp_sup, :v_temp_inf, :v_cortes, :v_discos, :v_archivo_disenyo_tipomaquina_disenyo, 
		:v_archivo_disenyo_codigo, :v_archivo_disenyo_prueba) 
	using transaccion;
	
	if transaccion.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_escandallo "+ transaccion.SQLErrText) 
		return "-1"
	end if
	
next


//////////////////////////////////////////////////////////////
// Cálculo del coste de MP todas las operaciones 
//////////////////////////////////////////////////////////////

sel = " select articulo, version, operacion "+&
		" from art_ver_operaciones "+&
		" where articulo = '"+v_codigo+"' "+&
		" and version = '"+v_version_destino+"' "
f_cargar_cursor_trans(transaccion, sel, regs_coste)

for i = 1 to regs_coste.rowcount()
	operacion = regs_coste.object.operacion[i]
	ver = regs_coste.object.version[i]
	
	select sum (coste_kg_formula * art_ver_op_aplicaciones.gramaje / 1000 ) 
	into :coste_mp_operacion
	from art_ver_op_aplicaciones, prodformula
	where art_ver_op_aplicaciones.empresa = :empresa
	and art_ver_op_aplicaciones.formula = prodformula.formula
	and art_ver_op_aplicaciones.articulo = :v_codigo
	and art_ver_op_aplicaciones.operacion = :operacion
	and art_ver_op_aplicaciones.version = :v_version_destino 
	using transaccion;
	
	update art_ver_operaciones
	set coste_mp = :coste_mp_operacion 
	where empresa = :empresa
	and articulo = :v_codigo
	and version = :v_version_destino
	and operacion = :operacion 
	using transaccion;
	
	if transaccion.SQLCode = -1 then return "-1"
next

destroy operaciones
destroy aplicaciones
destroy regs_coste
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
end function

public function string fr_duplicar_con_estructura_nueva (string articulo_a_duplicar, string articulo_origen_escandallo, string version_origen_escandallo, string aprovecha_origen_escandallo, decimal factor_origen_escandallo, transaction transaccion, string descripcion_ver_origen_escandallo, string observaciones_origen_escandallo, string tipo_ver_origen_escandallo, boolean bases);datastore operaciones, escandallo, aplicaciones
string v_codigo, v_descripcion, v_familia, v_formato, v_unidad, v_cuenta, v_sector, v_tono, v_calibre, v_compras, v_activo, v_prev_anular, relieve
string v_molde, v_plato_sup, v_plato_inf, v_cliente, v_codigo_pantallas, v_control_stock, v_usuario, v_calidad
dec v_pesopieza, v_espesor
dec{0} registros
datetime v_fecha_alta
boolean bien = true
string v_caja, v_codigopallet, v_caja2 
dec v_piezascaja, v_metroscaja, v_metroslcaja, v_pesocaja, v_metros_reales
int v_cajaspallet, v_planospallet, v_alturas
string v_g1, v_g2, v_g3, v_g4, v_pt, v_gd, v_nc, v_re, v_ee, v_av, v_pl, v_ct, v_en, v_tm, v_otr, v_n
string v_version, v_base, v_base2, descripcion, v_observaciones, v_articulo_ant, v_aprovecha_esc, v_coleccion, v_color, v_uso
int v_factor_base
string v_operacion, v_tipo_operacion, v_orden, v_formato_op, v_juegopantallas, v_descripcion_ver
int v_numaplicaciones
dec v_factor,  v_factor_Esc, i
string sel, v_marco, v_marcado, v_canto_vivo, v_tipo_version, v_coste
string v_operacion_apl, v_contadoraplicacion, v_pantalla, v_formula, v_tipoaplicacion, v_orden_apl
string v_boquilla, v_ciclo, v_temp_sup, v_temp_inf, v_cortes, v_discos , v_referencia_laboratorio, v_orientacion
dec v_gramaje, v_gram_7x20, v_densidad, v_viscosidad, v_piezas_fila
/////////////// Cáclulo del coste //////////////
dec coste_mp_operacion
string operacion, ver
datastore  regs_coste
long m, z
str_colisiones param_colisiones
////////////////////////////////////////////////

if articulo_a_duplicar = '0' or articulo_a_duplicar = '' or isnull(articulo_a_duplicar) then
	articulo_a_duplicar = "0" //Base
	v_codigo = "0"
else
	param_colisiones.empresa = codigo_empresa
	param_colisiones.tabla = "articulos"
	param_colisiones.campo = "codigo"
	param_colisiones.filtro = ""
	param_colisiones.buscar_huecos = false
	
	v_codigo = String(f_colisiones(transaccion, param_colisiones))
	//v_codigo = String(f_colisiones2(codigo_empresa, "articulos", "codigo", "",false))
end if

if not isnull(articulo_origen_escandallo) and articulo_origen_escandallo <> "" then //Caso de inicio 
	insert into
			art_escandallo (empresa, articulo, version, articulo_ant,  aprovecha, factor)
		values
			(:codigo_empresa, :articulo_origen_escandallo, :version_origen_escandallo, :v_codigo, :aprovecha_origen_escandallo, :factor_origen_escandallo ) 
	using transaccion;
	if transaccion.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_escandallo "+ transaccion.SQLErrText) 
		return "-1"
	end if	
	
	insert into
		art_versiones ( empresa, articulo, version, descripcion, observaciones, tipo_version, base)
	values
		(:codigo_empresa, :articulo_origen_escandallo, :version_origen_escandallo, :descripcion_ver_origen_escandallo, :observaciones_origen_escandallo, :tipo_ver_origen_escandallo, :v_codigo) 
	using transaccion;
		
	if transaccion.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_versiones "+ transaccion.SQLErrText) 
		return "-1"
	end if
end if
	
if articulo_a_duplicar = "0" then
	return ""
end if

//v_descripcion = 'ARTICULO NUEVO'
v_fecha_alta  = datetime(today(), now())
v_usuario = nombre_usuario
v_calidad = '1'
v_version = '1'

select descripcion, familia, formato, unidad, sector, tono, calibre, compras, activo, prev_anular, codigo_pantallas, 
			control_stock, pesopieza, espesor, coleccion, color, uso, marco, marcado, canto_vivo, referencia_laboratorio,
			molde, plato_sup, plato_inf, cliente, relieve
into :v_descripcion, :v_familia, :v_formato, :v_unidad, :v_sector, :v_tono, :v_calibre, :v_compras, :v_activo, :v_prev_anular, :v_codigo_pantallas,
		:v_control_stock, :v_pesopieza,:v_espesor, :v_coleccion, :v_color, :v_uso,	:v_marco, :v_marcado, :v_canto_vivo, :v_referencia_laboratorio,
		:v_molde, :v_plato_sup, :v_plato_inf, :v_cliente, :relieve
from articulos
where empresa = :codigo_empresa 
and codigo = :articulo_a_duplicar 
using transaccion;


 v_caja = '3'
 v_piezascaja = 999


select codigo, caja, cajaspallet, planospallet, alturas
into :v_codigopallet, :v_caja2, :v_cajaspallet, :v_planospallet, :v_alturas
from palarticulo
where empresa = :codigo_empresa
and articulo = :articulo_a_duplicar
and pordefecto = 'S' 
using transaccion;

v_codigopallet = '0'
v_caja2 = '3'
v_cajaspallet = 999
v_planospallet = 999
v_alturas = 999

/*
select tm
into :v_tm
from art_codestadistico
where empresa = :codigo_empresa
and codigo = :articulo_a_duplicar;
*/

select base,  descripcion, observaciones, tipo_version
into :v_base, :v_descripcion_ver, :v_observaciones, :v_tipo_version
from art_versiones
where empresa = :codigo_empresa
and articulo = :articulo_a_duplicar 
and version = :v_version
using transaccion;

insert into 	
	articulos (empresa, codigo, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, fecha_alta, 
	fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, pesoenvase, metroscaja, metroslcaja, 
	cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, 
	estilo, coleccion, color, imagen, referencia_laboratorio, version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, 
	temp_superior, ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, ubi_muestras, stocksugerido, 
	fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, marcado, etiqueta_ce, lote, observaciones, modelo_origen, pieza_origen, 
	prueba_origen, ean13_aux, bisel, relieve, cliente_marca, cod_cliente2)
SELECT empresa, :v_codigo, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, fecha_alta, fecha_anulado, fecha_fin, cuenta, 
	proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, 
	prev_anular, empleado, molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, referencia_laboratorio, version_laboratorio, 
	fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior, ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, 
	obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, 
	canto_vivo, marcado, etiqueta_ce, lote, observaciones, modelo_origen, pieza_origen, prueba_origen, ean13_aux, bisel, relieve, cliente_marca, cod_cliente2
FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo_a_duplicar 
using transaccion;

/*
values	 	
	(:codigo_empresa, :v_codigo, :v_descripcion, :v_fecha_alta, :v_familia, :v_formato, :v_unidad, :v_sector, :v_tono, :v_calibre, :v_compras, :v_activo, 
	:v_prev_anular, :v_codigo_pantallas, :v_control_stock, :nombre_usuario,:v_uso, :v_referencia_laboratorio, :relieve);				
*/	
	
if transaccion.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de articulos "+ transaccion.SQLErrText)
	return "-1"
end if

insert into
	almartcal (empresa, articulo, calidad, fecha_alta)
values
	(:codigo_empresa, :v_codigo, :v_calidad, :v_fecha_alta) 
using transaccion;

if transaccion.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de almartcal "+ transaccion.SQLErrText)
	return "-1"
end if

insert into
	almartcajas (empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales, pordefecto)
values
	(:codigo_empresa, : v_codigo, :v_caja, :v_piezascaja, :v_metroscaja, :v_metroslcaja, :v_pesocaja, :v_metros_reales, 'S') 
using transaccion;

if transaccion.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de almartcaja "+ transaccion.SQLErrText)
	return "-1"
end if

insert into 
	palarticulo (empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
values
	(:codigo_empresa,  :v_codigo, :v_codigopallet, :v_caja2, :v_cajaspallet, :v_planospallet, :v_alturas, 'S') 
using transaccion;

if transaccion.SQLCode <> 0 then 
	MessageBox("Error", "Error en el insert de palarticulo "+ transaccion.SQLErrText) 
	return "-1"
end if

insert into
	art_codestadistico (empresa, codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID)
(SELECT empresa, :v_codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID 
FROM art_codestadistico WHERE empresa = :codigo_empresa AND codigo = :articulo_a_duplicar) 
using transaccion;

if transaccion.SQLCode <> 0 then 
	MessageBox("Error", "Error en el insert de art_codestadistico "+ transaccion.SQLErrText) 
	return "-1"
end if

sel = "select operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila "+&
		" from art_ver_operaciones "+&
		" where empresa = "+codigo_empresa+&
		" and articulo = "+articulo_a_duplicar+&
		" and version = "+v_version;
		
f_cargar_cursor_trans(transaccion, sel, operaciones)

for i = 1 to operaciones.rowcount() 
	v_operacion = operaciones.object.operacion[i]
	v_tipo_operacion = operaciones.object.tipo_operacion[i]
	v_orden = operaciones.object.orden[i]
	v_formato_op = operaciones.object.formato[i]
	v_factor = 1
	v_juegopantallas = operaciones.object.juegopantallas[i]
	v_numaplicaciones = operaciones.object.numaplicaciones[i]
	v_coste = operaciones.object.coste[i]
	v_orientacion = operaciones.object.orientacion[i]
	v_piezas_fila =operaciones.object.piezas_fila[i]
	
	insert into
		art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila)
	values
		(:codigo_empresa, :v_codigo, :v_version, :v_operacion, :v_tipo_operacion, :v_orden	, :v_formato_op,  :v_factor, 
		:v_juegopantallas, :v_numaplicaciones, :v_coste, :v_orientacion, :v_piezas_fila) 
	using transaccion;
	
	if transaccion.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_versiones "+ transaccion.SQLErrText) 
		return "-1"
	end if
next



sel = " select operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, orden, densidad, viscosidad, "+&
		" boquilla, ciclo, temp_sup, temp_inf, cortes, discos "+&
		" from art_ver_op_aplicaciones "+&
		" where empresa = "+codigo_empresa+&
		" and articulo = "+articulo_a_duplicar+&
		" and version = "+v_version;
		
f_cargar_cursor_trans(transaccion, sel, aplicaciones)

for i = 1 to aplicaciones.rowcount()
	v_operacion_apl = aplicaciones.object.operacion[i]
	v_contadoraplicacion = aplicaciones.object.contadoraplicacion[i]
	v_pantalla = aplicaciones.object.pantalla[i]
	v_formula = aplicaciones.object.formula[i]
	v_tipoaplicacion = aplicaciones.object.tipoaplicacion[i]
	v_orden_apl = aplicaciones.object.orden[i]
	v_boquilla = aplicaciones.object.boquilla[i]
	v_ciclo = aplicaciones.object.ciclo[i]
	v_temp_sup = aplicaciones.object.temp_sup[i]
	v_temp_inf = aplicaciones.object.temp_inf[i]
	v_cortes = aplicaciones.object.cortes[i]
	v_discos = aplicaciones.object.discos[i]
	v_gramaje = aplicaciones.object.gramaje[i]
	v_gram_7x20 = aplicaciones.object.gram_7x20[i]
	v_densidad = aplicaciones.object.densidad[i]
	v_viscosidad = aplicaciones.object.viscosidad[i]

	insert into
		art_ver_op_aplicaciones (empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, 
										orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos)
	values
		(:codigo_empresa, :v_codigo, :v_version, :v_operacion_apl, :v_contadoraplicacion, :v_pantalla, :v_formula, :v_gramaje, :v_gram_7x20, :v_tipoaplicacion,
		:v_orden_apl, :v_densidad, :v_viscosidad, :v_boquilla, :v_ciclo, :v_temp_sup, :v_temp_inf, :v_cortes, :v_discos) 
	using transaccion;
	
	if transaccion.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_escandallo "+ transaccion.SQLErrText) 
		return "-1"
	end if
	
next


//////////////////////////////////////////////////////////////
// Cálculo del coste de MP todas las operaciones 
//////////////////////////////////////////////////////////////

sel = " select articulo, version, operacion "+&
		" from art_ver_operaciones "+&
		" where articulo = '"+v_codigo+"' "+&
		" and version = '1' "
f_cargar_cursor_trans(transaccion, sel, regs_coste)

for m = 1 to regs_coste.rowcount()
	operacion = regs_coste.object.operacion[m]
	ver = regs_coste.object.version[m]
	
	select sum (coste_kg_formula * art_ver_op_aplicaciones.gramaje / 1000 ) 
	into :coste_mp_operacion
	from art_ver_op_aplicaciones, prodformula
	where art_ver_op_aplicaciones.empresa = :codigo_empresa
	and art_ver_op_aplicaciones.formula = prodformula.formula
	and art_ver_op_aplicaciones.articulo = :v_codigo
	and art_ver_op_aplicaciones.operacion = :operacion
	and art_ver_op_aplicaciones.version = :ver 
	using transaccion;
	
	update art_ver_operaciones
	set coste_mp = :coste_mp_operacion 
	where empresa = :codigo_empresa
	and articulo = :v_codigo
	and version = :ver
	and operacion = :operacion 
	using transaccion;
	
	if transaccion.SQLCode = -1 then return "-1"
next

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

sel = " select articulo_ant, factor, aprovecha "+&
		" from art_escandallo "+&
		" where empresa = "+codigo_empresa+&
		" and articulo = "+articulo_a_duplicar+&
		" and version = "+v_version;
		
f_cargar_cursor_trans(transaccion, sel, escandallo)

for z = 1 to escandallo.rowcount()
	
	v_articulo_ant = escandallo.object.articulo_ant[z]
	v_aprovecha_esc = escandallo.object.aprovecha[z]
	v_factor_esc = escandallo.object.factor[z]
	
	if fr_duplicar_con_estructura_nueva(v_articulo_ant, v_codigo, v_version, v_aprovecha_esc, v_factor_esc, transaccion, v_descripcion_ver, v_observaciones, v_tipo_version, bases) = "-1" then
		return "-1"
	end if
next

destroy (operaciones)
destroy (escandallo)
destroy (aplicaciones)

return v_codigo
end function

public subroutine f_cambiar_nombres ();// Cambia los nombres de los artículos seleccionados
Long i, total, rtn = 1
String codigo, descripcion, codigo_origen  

codigo_origen = sle_busqueda.text

dw_imprimir_seleccionados.accepttext()

total = dw_imprimir_seleccionados.rowcount()
i = 1
do while i <= total and rtn = 1 

	codigo = dw_imprimir_seleccionados.object.codigo[i]
	descripcion = dw_imprimir_seleccionados.object.descripcion[i]
	
	UPDATE articulos 
	SET descripcion = :descripcion 
	WHERE empresa = :codigo_empresa 
		AND codigo = :codigo 
	USING trans_ts;
	if trans_ts.SQLCode <> 0 then
		MessageBox("Error", "Error actualizando nombre articulo "+ trans_ts.SQLErrText)
		rtn = -1
	end if
	
	i++
loop

if rtn = 1 then
	COMMIT USING trans_ts;
	sle_valor.text = codigo_origen
	sle_valor.triggerevent("tecla_tabulador")
	sle_busqueda.text = codigo_origen
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(codigo_origen, 0, tv_escandallo)
	dw_imprimir_seleccionados.visible = false
else
	ROLLBACK USING trans_ts;
end if


end subroutine

public function string fr_duplicar_estructura_dw (string articulo_a_duplicar, string articulo_origen_escandallo, string version_origen_escandallo, string aprovecha_origen_escandallo, decimal factor_origen_escandallo, transaction arg_trans, string descripcion_ver_origen_escandallo, string observaciones_origen_escandallo, string tipo_ver_origen_escandallo, long fila);datastore operaciones, escandallo, aplicaciones
string v_codigo, v_descripcion, v_familia, v_formato, v_unidad, v_cuenta, v_sector, v_tono, v_calibre, v_compras, v_activo, v_prev_anular, relieve
string v_molde, v_plato_sup, v_plato_inf, v_cliente, v_codigo_pantallas, v_control_stock, v_usuario, v_calidad
dec v_pesopieza, v_espesor
dec{0} registros
datetime v_fecha_alta
boolean bien = true
string v_caja, v_codigopallet, v_caja2 
dec v_piezascaja, v_metroscaja, v_metroslcaja, v_pesocaja, v_metros_reales
int v_cajaspallet, v_planospallet, v_alturas
string v_g1, v_g2, v_g3, v_g4, v_pt, v_gd, v_nc, v_re, v_ee, v_av, v_pl, v_ct, v_en, v_tm, v_otr, v_n
string v_version, v_base, v_base2, descripcion, v_observaciones, v_articulo_ant, v_aprovecha_esc, v_coleccion, v_color, v_uso
int v_factor_base
string v_operacion, v_tipo_operacion, v_orden, v_formato_op, v_juegopantallas, v_descripcion_ver
int v_numaplicaciones
dec v_factor,  v_factor_Esc, i
string sel, v_marco, v_marcado, v_canto_vivo, v_tipo_version, v_coste
string v_operacion_apl, v_contadoraplicacion, v_pantalla, v_formula, v_tipoaplicacion, v_orden_apl
string v_boquilla, v_ciclo, v_temp_sup, v_temp_inf, v_cortes, v_discos , v_referencia_laboratorio, v_orientacion, v_modelo_origen, v_pieza_origen, v_prueba_origen
dec v_gramaje, v_gram_7x20, v_densidad, v_viscosidad, v_piezas_fila
/////////////// Cáclulo del coste //////////////
dec coste_mp_operacion
string operacion, ver
datastore  regs_coste
long m, z, v_version_laboratorio
str_colisiones param_colisiones
////////////////////////////////////////////////

descripcion_ver_origen_escandallo = "ÚNICA"
observaciones_origen_escandallo = ""
tipo_ver_origen_escandallo = "P"

if articulo_a_duplicar = '0' or articulo_a_duplicar = '' or isnull(articulo_a_duplicar) then
	articulo_a_duplicar = "0" //Base
	if not isnull(dw_articulo_final.object.codigo[1]) and dw_articulo_final.object.codigo[1] <> "" then
		v_codigo = dw_articulo_final.object.codigo[1]
	else
		v_codigo = "0"
	end if
else
	param_colisiones.empresa = codigo_empresa
	param_colisiones.tabla = "articulos"
	param_colisiones.campo = "codigo"
	param_colisiones.filtro = ""
	param_colisiones.buscar_huecos = false
	
	
	v_codigo = String(f_colisiones(arg_trans, param_colisiones))
	//v_codigo = String(f_colisiones2(codigo_empresa, "articulos", "codigo", "",false))
end if

if not isnull(articulo_origen_escandallo) and articulo_origen_escandallo <> "" then //Caso de inicio 
	insert into
			art_escandallo (empresa, articulo, version, articulo_ant,  factor)
		values
			(:codigo_empresa, :articulo_origen_escandallo, :version_origen_escandallo, :v_codigo, :factor_origen_escandallo ) 
	using arg_trans;
	if arg_trans.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_escandallo "+ arg_trans.SQLErrText) 
		return "-1"
	end if	
	
	insert into
		art_versiones ( empresa, articulo, version, descripcion, observaciones, tipo_version, base)
	values
		(:codigo_empresa, :articulo_origen_escandallo, :version_origen_escandallo, :descripcion_ver_origen_escandallo, :observaciones_origen_escandallo, :tipo_ver_origen_escandallo, :v_codigo) 
	using arg_trans;
		
	if arg_trans.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_versiones "+ arg_trans.SQLErrText) 
		return "-1"
	end if
end if

if articulo_a_duplicar = "0" then
	return ""
end if

//v_descripcion = 'ARTICULO NUEVO'
v_fecha_alta  = datetime(today(), now())
v_usuario = nombre_usuario
v_calidad = '1'
v_version = '1'

v_caja = '3'
v_piezascaja = 999

select codigo, caja, cajaspallet, planospallet, alturas
into :v_codigopallet, :v_caja2, :v_cajaspallet, :v_planospallet, :v_alturas
from palarticulo
where empresa = :codigo_empresa
and articulo = :articulo_a_duplicar
and pordefecto = 'S' 
using arg_trans;

v_codigopallet = '0'
v_caja2 = '3'
v_cajaspallet = 999
v_planospallet = 999
v_alturas = 999

/*
select tm
into :v_tm
from art_codestadistico
where empresa = :codigo_empresa
and codigo = :articulo_a_duplicar;
*/

select base,  descripcion, observaciones, tipo_version
into :v_base, :v_descripcion_ver, :v_observaciones, :v_tipo_version
from art_versiones
where empresa = :codigo_empresa
and articulo = :articulo_a_duplicar 
and version = :v_version
using arg_trans;



v_descripcion = dw_imprimir_seleccionados.object.descripcion[fila]
v_referencia_laboratorio = dw_referencias.object.ant_modelo[1]
v_version_laboratorio = dw_referencias.object.ant_prueba[1]
v_modelo_origen = dw_referencias.object.modelo[1]
v_pieza_origen = dw_referencias.object.pieza[1]
v_prueba_origen = dw_referencias.object.prueba[1]

Datetime fecha_alta = Datetime(Today(),now())

insert into 	
	articulos (empresa, codigo, descripcion, familia, marcas_codigo, submarcas_codigo, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, fecha_alta, 
	fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, pesoenvase, metroscaja, metroslcaja, 
	cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, 
	estilo, coleccion, color, imagen, referencia_laboratorio, version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, 
	temp_superior,  ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, ubi_muestras, stocksugerido, 
	fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, marcado, etiqueta_ce, lote, observaciones, modelo_origen, pieza_origen, 
	prueba_origen, ean13_aux, bisel, relieve, cliente_marca, cod_cliente2, costilla, ancho_std,largo_std,formato_etiqueta,espesor_lateral,promocion)
SELECT empresa, :v_codigo, :v_descripcion, familia, marcas_codigo, submarcas_codigo, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, :fecha_alta, fecha_anulado, fecha_fin, cuenta, 
	proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, 
	prev_anular, empleado, molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, :v_referencia_laboratorio, :v_version_laboratorio, 
	fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior,  ventasitalia, usuario, temp_inferior1, temp_superior1, 
	obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, 
	canto_vivo, marcado, etiqueta_ce, lote, observaciones, :v_modelo_origen, :v_pieza_origen, :v_prueba_origen, ean13_aux, bisel, relieve, cliente_marca, cod_cliente2, costilla, ancho_std, largo_std, formato_etiqueta,espesor_lateral,promocion
FROM articulos WHERE empresa = :codigo_empresa AND codigo = :articulo_a_duplicar 
using arg_trans;

/*
values	 	
	(:codigo_empresa, :v_codigo, :v_descripcion, :v_fecha_alta, :v_familia, :v_formato, :v_unidad, :v_sector, :v_tono, :v_calibre, :v_compras, :v_activo, 
	:v_prev_anular, :v_codigo_pantallas, :v_control_stock, :nombre_usuario,:v_uso, :v_referencia_laboratorio, :relieve);				
*/	
	
if arg_trans.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de articulos "+ arg_trans.SQLErrText)
	return "-1"
end if

insert into
	almartcal (empresa, articulo, calidad, fecha_alta)
values
	(:codigo_empresa, :v_codigo, :v_calidad, :v_fecha_alta) 
using arg_trans;

if arg_trans.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de almartcal "+ arg_trans.SQLErrText)
	return "-1"
end if

insert into
	almartcajas (empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales, pordefecto)
values
	(:codigo_empresa, : v_codigo, :v_caja, :v_piezascaja, :v_metroscaja, :v_metroslcaja, :v_pesocaja, :v_metros_reales, 'S') 
using arg_trans;

if arg_trans.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de almartcaja "+ arg_trans.SQLErrText)
	return "-1"
end if

insert into 
	palarticulo (empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
values
	(:codigo_empresa,  :v_codigo, :v_codigopallet, :v_caja2, :v_cajaspallet, :v_planospallet, :v_alturas, 'S') 
using arg_trans;

if arg_trans.SQLCode <> 0 then 
	MessageBox("Error", "Error en el insert de palarticulo "+ arg_trans.SQLErrText) 
	return "-1"
end if

insert into
	art_codestadistico (empresa, codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID)
(SELECT empresa, :v_codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID 
FROM art_codestadistico WHERE empresa = :codigo_empresa AND codigo = :articulo_a_duplicar) 
using arg_trans;

if arg_trans.SQLCode <> 0 then 
	MessageBox("Error", "Error en el insert de art_codestadistico "+ arg_trans.SQLErrText) 
	return "-1"
end if

sel = "select operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila "+&
		" from art_ver_operaciones "+&
		" where empresa = "+codigo_empresa+&
		" and articulo = "+articulo_a_duplicar+&
		" and version = "+v_version;
		
f_cargar_cursor_trans(arg_trans, sel, operaciones)

for i = 1 to operaciones.rowcount() 
	v_operacion = operaciones.object.operacion[i]
	v_tipo_operacion = operaciones.object.tipo_operacion[i]
	v_orden = operaciones.object.orden[i]
	v_formato_op = operaciones.object.formato[i]
	v_factor = 1
	v_juegopantallas = operaciones.object.juegopantallas[i]
	v_numaplicaciones = operaciones.object.numaplicaciones[i]
	v_coste = operaciones.object.coste[i]
	v_orientacion = operaciones.object.orientacion[i]
	v_piezas_fila =operaciones.object.piezas_fila[i]
	
	insert into
		art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila)
	values
		(:codigo_empresa, :v_codigo, :v_version, :v_operacion, :v_tipo_operacion, :v_orden	, :v_formato_op,  :v_factor, 
		:v_juegopantallas, :v_numaplicaciones, :v_coste, :v_orientacion, :v_piezas_fila) 
	using arg_trans;
	
	if arg_trans.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_versiones "+ arg_trans.SQLErrText) 
		return "-1"
	end if
next



sel = " select operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, orden, densidad, viscosidad, "+&
		" boquilla, ciclo, temp_sup, temp_inf, cortes, discos "+&
		" from art_ver_op_aplicaciones "+&
		" where empresa = "+codigo_empresa+&
		" and articulo = "+articulo_a_duplicar+&
		" and version = "+v_version;
		
f_cargar_cursor_trans(arg_trans, sel, aplicaciones)

for i = 1 to aplicaciones.rowcount()
	v_operacion_apl = aplicaciones.object.operacion[i]
	v_contadoraplicacion = aplicaciones.object.contadoraplicacion[i]
	v_pantalla = aplicaciones.object.pantalla[i]
	v_formula = aplicaciones.object.formula[i]
	v_tipoaplicacion = aplicaciones.object.tipoaplicacion[i]
	v_orden_apl = aplicaciones.object.orden[i]
	v_boquilla = aplicaciones.object.boquilla[i]
	v_ciclo = aplicaciones.object.ciclo[i]
	v_temp_sup = aplicaciones.object.temp_sup[i]
	v_temp_inf = aplicaciones.object.temp_inf[i]
	v_cortes = aplicaciones.object.cortes[i]
	v_discos = aplicaciones.object.discos[i]
//	v_gramaje = aplicaciones.object.gramaje[i]
//	v_gram_7x20 = aplicaciones.object.gram_7x20[i]
	v_gramaje = 0
	v_gram_7x20 = 0
	v_densidad = aplicaciones.object.densidad[i]
	v_viscosidad = aplicaciones.object.viscosidad[i]

	insert into
		art_ver_op_aplicaciones (empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, 
										orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos)
	values
		(:codigo_empresa, :v_codigo, :v_version, :v_operacion_apl, :v_contadoraplicacion, :v_pantalla, :v_formula, :v_gramaje, :v_gram_7x20, :v_tipoaplicacion,
		:v_orden_apl, :v_densidad, :v_viscosidad, :v_boquilla, :v_ciclo, :v_temp_sup, :v_temp_inf, :v_cortes, :v_discos) 
	using arg_trans;
	
	if arg_trans.SQLCode <> 0 then 
		MessageBox("Error", "Error en el insert de art_escandallo "+ arg_trans.SQLErrText) 
		return "-1"
	end if
	
next


//////////////////////////////////////////////////////////////
// Cálculo del coste de MP todas las operaciones 
//////////////////////////////////////////////////////////////

sel = " select articulo, version, operacion "+&
		" from art_ver_operaciones "+&
		" where articulo = '"+v_codigo+"' "+&
		" and version = '1' "
f_cargar_cursor_trans(arg_trans, sel, regs_coste)

for m = 1 to regs_coste.rowcount()
	operacion = regs_coste.object.operacion[m]
	ver = regs_coste.object.version[m]
	
	select sum (coste_kg_formula * art_ver_op_aplicaciones.gramaje / 1000 ) 
	into :coste_mp_operacion
	from art_ver_op_aplicaciones, prodformula
	where art_ver_op_aplicaciones.empresa = :codigo_empresa
	and art_ver_op_aplicaciones.formula = prodformula.formula
	and art_ver_op_aplicaciones.articulo = :v_codigo
	and art_ver_op_aplicaciones.operacion = :operacion
	and art_ver_op_aplicaciones.version = :ver 
	using arg_trans;
	
	update art_ver_operaciones
	set coste_mp = :coste_mp_operacion 
	where empresa = :codigo_empresa
	and articulo = :v_codigo
	and version = :ver
	and operacion = :operacion 
	using arg_trans;
	
	if arg_trans.SQLCode = -1 then return "-1"
next

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

if fila < dw_imprimir_seleccionados.rowcount() then 
	fila = fila +1
	v_articulo_ant = dw_imprimir_seleccionados.object.codigo[fila]
	v_factor_esc = dw_imprimir_seleccionados.object.factor[fila]
else
	fila = fila +1
	v_articulo_ant = "0"
	v_factor_esc = 1
end if

if fr_duplicar_estructura_dw(v_articulo_ant, v_codigo, v_version, v_aprovecha_esc, v_factor_esc, arg_trans, v_descripcion_ver, v_observaciones, v_tipo_version, fila) = "-1" then
	return "-1"
end if

destroy (operaciones)
destroy (escandallo)
destroy (aplicaciones)

return v_codigo
end function

public function integer fr_cambio_parametros_base (str_aux_parametros_base parametros, string articulo);String sel, siguiente, uso
Datastore escandallo
Long i
Int resultado = 1

SELECT articulo_ant 
INTO :siguiente 
FROM art_escandallo 
WHERE empresa = :codigo_empresa AND articulo = :articulo;

sel =  "SELECT articulo_ant "+&
		"FROM art_escandallo "+&
		"WHERE empresa = '"+codigo_empresa+"' AND articulo = '"+articulo+"' "
f_cargar_cursor_trans (SQLCA,  sel,  escandallo)

i = 1
Do while i <= escandallo.RowCount()
	siguiente = trim(escandallo.object.articulo_ant[i])
	if isnull(siguiente) then siguiente = ""
	if siguiente <> "" and siguiente <> "0" then
		uso = ""
		SELECT uso INTO :uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :siguiente;
		if uso <> "1" then		
			resultado = fr_cambio_parametros_base(parametros, siguiente)
			if resultado = 1 then
				UPDATE articulos 
				SET molde = :parametros.molde, plato_sup = :parametros.plato_sup, plato_inf = :parametros.plato_inf, costilla = :parametros.costilla,
					familia = :parametros.familia, relieve = :parametros.relieve, cliente = :parametros.cliente, //descripcion = :parametros.descripcion, 
					espesor =  :parametros.espesor, espesor_lateral =  :parametros.espesor_lateral, pesopieza = :parametros.pesopieza, marco = :parametros.marco 
				WHERE empresa = :codigo_empresa AND codigo = :siguiente;
				IF SQLCA.SQLCode <> 0 THEN         
					MessageBox("SQL error ", SQLCA.SQLErrText)
					resultado = 0
				END IF
			
				UPDATE art_codestadistico
				SET pt = :parametros.pt
				WHERE empresa = :codigo_empresa AND codigo = :siguiente;
				
				IF SQLCA.SQLCode <> 0 THEN         
					MessageBox("SQL error ", SQLCA.SQLErrText)
					resultado = 0
				END IF
						
			end if 
		end if // FIN IF BASE
	end if //FIN IF siguiente = ""
	i++
Loop

Destroy escandallo
return resultado
end function

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
cb_duplicar.enabled = true
TV_ESCANDALLO.ENABLED = TRUE
TV_ESCANDALLO.BACKCOLOR = RGB(255,255,255)
sle_busqueda.enabled = true 
cb_2.enabled = true 
cb_4.enabled = true 

cb_añadir_ver.enabled = false
cb_eliminar_ver.enabled = false

cb_añadir.enabled = false
cb_eliminar.enabled = false
cb_intercalar.enabled = false
cb_añadir2.enabled = false
cb_eliminar2.enabled = false
cb_intercalar2.enabled = false
cb_añadir3.enabled = false
cb_eliminar3.enabled = false


end event

event open;call super::open;integer permiso

permiso = f_permiso_usuario( string(this.classname()), nombre_usuario)

choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
		This.cb_duplicar_todo.visible = false;		
		This.cb_duplicar.visible = false;		
		This.cb_añadir.visible = false;		
		This.cb_añadir2.visible = false;		
		This.cb_añadir3.visible = false;		
		This.cb_añadir_ver.visible = false;		
		This.cb_eliminar.visible = false;		
		This.cb_eliminar2.visible = false;		
		This.cb_eliminar3.visible = false;		
		This.cb_eliminar_ver.visible = false;		
		This.cb_intercalar.visible = false;		
		This.cb_intercalar2.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Altas de Artículos Semielaborados"

This.title = istr_parametros.s_titulo_ventana

dw_codestadistico.SetTransObject(SQLCA)
dw_caja_articulo.SetTransObject(SQLCA)
dw_paletizado.SetTransObject(SQLCA)
dw_calidad_altas.SetTransObject(SQLCA)
dw_versiones.SetTransObject(SQLCA)
dw_operaciones.SetTransObject(SQLCA)
dw_aplicaciones.SetTransObject(SQLCA)
dw_escandallo.SetTransObject(SQLCA)
dw_cajas.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	sle_busqueda.text=istr_parametros.s_argumentos[2]
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(istr_parametros.s_argumentos[2], 0, tv_escandallo)

	dw_1.SetTransObject(SQLCA)
	f_activar_campo(sle_valor)
	
	
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_versiones.Retrieve(codigo_empresa,sle_valor.Text)
		dw_codestadistico.Retrieve(codigo_empresa,sle_valor.Text)

	END IF
END IF

	
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
cb_duplicar.enabled = false
TV_ESCANDALLO.ENABLED = false
TV_ESCANDALLO.BACKCOLOR = RGB(201,201,201)
sle_busqueda.enabled = false 
cb_2.enabled = false 
cb_4.enabled = false 

cb_añadir_ver.enabled = true
cb_eliminar_ver.enabled = true

cb_añadir.enabled = true
cb_eliminar.enabled = true
cb_intercalar.enabled = true
cb_añadir2.enabled = true
cb_eliminar2.enabled = true
cb_intercalar2.enabled = true
cb_añadir3.enabled = true
cb_eliminar3.enabled = true


end event

event ue_inserta_fila;call super::ue_inserta_fila;long fila

dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"articulos_activo",'S')
dw_1.setitem(dw_1.getrow(),"articulos_unidad",'0')
dw_1.setitem(dw_1.getrow(),"articulos_familia",'1')
dw_1.setitem(dw_1.getrow(),"articulos_fecha_alta", datetime ( date(string ( today(), 'dd-mm-yyyy' ) ) ) )


dw_1.setitem(dw_1.getrow(),"articulos_sector",'S')
dw_1.setitem(dw_1.getrow(),"articulos_usuario",nombre_usuario)
dw_1.setitem(dw_1.getrow(),"articulos_tono",'N')
dw_1.setitem(dw_1.getrow(),"articulos_calibre",'N')
dw_1.setitem(dw_1.getrow(),"articulos_uso",'2')
dw_1.setitem(dw_1.getrow(),"articulos_control_stock",'S')

fila = dw_codestadistico.insertrow(0)
dw_codestadistico.ScrollToRow(fila)
dw_codestadistico.setitem(fila, "empresa", codigo_empresa)
dw_codestadistico.setitem(fila, "codigo", sle_valor.text)

fila = dw_caja_articulo.insertrow(0)
dw_caja_articulo.setitem(fila, "almartcajas_empresa", codigo_empresa)
dw_caja_articulo.setitem(fila, "almartcajas_articulo", sle_valor.text)
dw_caja_articulo.setitem(fila, "almartcajas_pordefecto", 'S')
dw_caja_articulo.setitem(fila, "almartcajas_caja", '3')
dw_caja_articulo.setitem(fila, "almartcajas_piezascaja", 999)

fila = dw_paletizado.insertrow(0)
dw_paletizado.setitem(fila, "palarticulo_empresa", codigo_empresa)
dw_paletizado.setitem(fila, "palarticulo_articulo", sle_valor.text)
dw_paletizado.setitem(fila, "palarticulo_pordefecto", 'S')
dw_paletizado.setitem(fila, "palarticulo_codigo", '0')
dw_paletizado.setitem(fila, "palarticulo_caja", '3')
dw_paletizado.setitem(fila, "palarticulo_cajaspallet", 999)
dw_paletizado.setitem(fila, "palarticulo_planospallet", 999)
dw_paletizado.setitem(fila, "palarticulo_alturas", 999)


fila = dw_calidad_altas.insertrow(0)
dw_calidad_altas.setitem(fila, "empresa", codigo_empresa)
dw_calidad_altas.setitem(fila, "articulo", sle_valor.text)
dw_calidad_altas.setitem(fila, "calidad", '1')
dw_calidad_altas.setitem(dw_1.getrow(),"fecha_alta", datetime ( date(string ( today(), 'dd-mm-yyyy' ) ) ) )



/*
//dw_caja_articulo		  
	ELSEIF IsNull(dw_caja_articulo.object.almartcajas_caja[k]) or Trim(String(dw_caja_articulo.object.almartcajas_caja[k]))='' THEN
		  campo="almartcajas_caja"
		  motivo  = "(Campo Obligatorio) Introduzca Caja."
		  dato = dw_caja_articulo
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_caja_articulo.object.almartcajas_piezascaja[k]) or dw_caja_articulo.object.almartcajas_piezascaja[k]=0 THEN
		  campo="almartcajas_piezascaja"
		  motivo  = "(Campo Obligatorio) Introduzca Piezas / caja."
		  dato = dw_caja_articulo
		  numero = 1
		  falta_campo = True
//dw_paletizado
	ELSEIF IsNull(dw_paletizado.object.palarticulo_codigo[k]) or Trim(String(dw_paletizado.object.palarticulo_codigo[k]))="" THEN
		  campo="palarticulo_codigo"
		  motivo  = "(Campo Obligatorio) Introduzca pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_caja[k]) or Trim(String(dw_paletizado.object.palarticulo_caja[k]))="" THEN
		  campo="palarticulo_caja"
		  motivo  = "(Campo Obligatorio) Introduzca Caja."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_cajaspallet[k]) or dw_paletizado.object.palarticulo_cajaspallet[k]=0 THEN
		  campo="palarticulo_cajaspallet"
		  motivo  = "(Campo Obligatorio) Introduzca Cajas / Pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_planospallet[k]) or dw_paletizado.object.palarticulo_planospallet[k]=0 THEN
		  campo="palarticulo_planospallet"
		  motivo  = "(Campo Obligatorio) Introduzca Planos / Pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_paletizado.object.palarticulo_alturas[k]) or dw_paletizado.object.palarticulo_alturas[k]= 0 THEN
		  campo="palarticulo_alturas"
		  motivo  = "(Campo Obligatorio) Introduzca Alturas / Pallet."
		  dato = dw_paletizado
		  numero = 1
		  falta_campo = True
	*/
end event

event ue_recuperar;string ver, fecha_anulado
Long bloqueado

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "articulos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_cajas.Retrieve(codigo_empresa,sle_valor.Text)
dw_codestadistico.Retrieve(codigo_empresa,sle_valor.Text)
dw_caja_articulo.Retrieve(codigo_empresa,sle_valor.Text)
dw_paletizado.Retrieve(codigo_empresa,sle_valor.Text)
dw_calidad_altas.Retrieve(codigo_empresa,sle_valor.Text)
dw_2.Retrieve(codigo_empresa,sle_valor.Text)

if sle_valor.Text <> "" then
	dw_versiones.retrieve(codigo_empresa,sle_valor.text)
	If dw_versiones.GetRow() > 0 Then 
	  dw_versiones.SetRow(1)
	end if
	if dw_versiones.rowcount() > 0 then
		ver = dw_versiones.object.version[dw_versiones.getrow()]
		if ver <> '' and not isnull (ver) then
			dw_escandallo.retrieve(codigo_empresa,sle_valor.text, ver)
			If dw_escandallo.GetRow() > 0 Then 
			  dw_escandallo.SetRow(1)
			end if
		end if
	end if
	
end if
///////////////////////////////////////////////////////
// 	CONTROL STOCK, PEDIDO Y PLANIFICADO
///////////////////////////////////////////////////////
	st_mensaje.text = ''

	if dw_1.rowcount() > 0 then
		boolean hay_pedido, hay_stock, hay_planificado
		int total
		string texto
		
		hay_pedido = false
		hay_stock = false
		hay_planificado = false
		texto = ""
		
		total = 0
		select count(*)
		into :total
		from venliped
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text;
		
		if total > 0 then	
			hay_pedido = true
			texto = "Hay Pedido. "
		end if
		
		total = 0
		select SUM(cantidade - cantidads)
		into :total
		from almacenmovimientos
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text
		group by articulo;
		
		if total > 0 then	
			hay_stock = true
			texto = texto + "Hay stock. "
		end if
		
		total = 0
		select count(*)
		into :total
		from planificacion
		where empresa = :codigo_empresa
		and cod_articulo = :sle_valor.text;
		
		if total > 0 then	
			hay_planificado = true
			texto = texto + "Hay Planificado. "
		end if
		
		if dw_1.object.articulos_bloqueado[1] = 'S' then
			texto = texto + "Bloqueado. "
		end if
		
		fecha_anulado = String(dw_1.object.articulos_fecha_anulado[1])
		if isnull(fecha_anulado) or fecha_anulado = "" then
			//texto = texto + "Activo. "
		else
			texto = texto + "Anulado. "
		end if
		
		if texto <> '' then
			st_mensaje.text = texto
//			messagebox("Aviso", nombre_usuario+": "+texto)
		end if 
	end if
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

sle_valor.setfocus()

CALL Super::ue_recuperar




end event

on w_mant_altas_intermedios_nuevo.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_listado=create dw_listado
this.dw_codestadistico=create dw_codestadistico
this.dw_caja_articulo=create dw_caja_articulo
this.dw_paletizado=create dw_paletizado
this.dw_calidad_altas=create dw_calidad_altas
this.cb_duplicar=create cb_duplicar
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_listado_ficha=create dw_listado_ficha
this.cb_añadir_ver=create cb_añadir_ver
this.cb_eliminar_ver=create cb_eliminar_ver
this.st_2=create st_2
this.cb_añadir=create cb_añadir
this.cb_eliminar=create cb_eliminar
this.cb_intercalar=create cb_intercalar
this.st_3=create st_3
this.dw_aplicaciones=create dw_aplicaciones
this.cb_añadir2=create cb_añadir2
this.cb_eliminar2=create cb_eliminar2
this.cb_intercalar2=create cb_intercalar2
this.dw_escandallo=create dw_escandallo
this.cb_añadir3=create cb_añadir3
this.r_2=create r_2
this.r_1=create r_1
this.r_3=create r_3
this.st_50=create st_50
this.cb_duplicar_todo=create cb_duplicar_todo
this.dw_versiones=create dw_versiones
this.pb_4=create pb_4
this.pb_anterior=create pb_anterior
this.pb_siguiente=create pb_siguiente
this.st_mensaje=create st_mensaje
this.pb_1=create pb_1
this.st_6=create st_6
this.dw_operaciones=create dw_operaciones
this.sle_busqueda=create sle_busqueda
this.tv_escandallo=create tv_escandallo
this.cb_2=create cb_2
this.cb_4=create cb_4
this.st_aplicaciones=create st_aplicaciones
this.dw_articulos_ant=create dw_articulos_ant
this.pb_bloquear_1=create pb_bloquear_1
this.pb_bloquear_estructura=create pb_bloquear_estructura
this.pb_2=create pb_2
this.pb_3=create pb_3
this.dw_imagen=create dw_imagen
this.cb_eliminar3=create cb_eliminar3
this.st_5=create st_5
this.pb_archivos_modelo=create pb_archivos_modelo
this.st_7=create st_7
this.cb_6=create cb_6
this.dw_listado_ficha2=create dw_listado_ficha2
this.cb_7=create cb_7
this.dw_articulo_inicial=create dw_articulo_inicial
this.dw_articulo_final=create dw_articulo_final
this.dw_referencias=create dw_referencias
this.cb_5=create cb_5
this.p_imagen=create p_imagen
this.cb_8=create cb_8
this.st_contador=create st_contador
this.cb_copiar_parametros=create cb_copiar_parametros
this.dw_cajas=create dw_cajas
this.dw_ruta_duplicar=create dw_ruta_duplicar
this.mle_observaciones=create mle_observaciones
this.dw_imagenes_modelo=create dw_imagenes_modelo
this.dw_articulos_post=create dw_articulos_post
this.dw_2=create dw_2
this.cb_9=create cb_9
this.dw_imprimir_seleccionados=create dw_imprimir_seleccionados
this.dw_listado_ficha3=create dw_listado_ficha3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.dw_codestadistico
this.Control[iCurrent+4]=this.dw_caja_articulo
this.Control[iCurrent+5]=this.dw_paletizado
this.Control[iCurrent+6]=this.dw_calidad_altas
this.Control[iCurrent+7]=this.cb_duplicar
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_listado_ficha
this.Control[iCurrent+11]=this.cb_añadir_ver
this.Control[iCurrent+12]=this.cb_eliminar_ver
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.cb_añadir
this.Control[iCurrent+15]=this.cb_eliminar
this.Control[iCurrent+16]=this.cb_intercalar
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.dw_aplicaciones
this.Control[iCurrent+19]=this.cb_añadir2
this.Control[iCurrent+20]=this.cb_eliminar2
this.Control[iCurrent+21]=this.cb_intercalar2
this.Control[iCurrent+22]=this.dw_escandallo
this.Control[iCurrent+23]=this.cb_añadir3
this.Control[iCurrent+24]=this.r_2
this.Control[iCurrent+25]=this.r_1
this.Control[iCurrent+26]=this.r_3
this.Control[iCurrent+27]=this.st_50
this.Control[iCurrent+28]=this.cb_duplicar_todo
this.Control[iCurrent+29]=this.dw_versiones
this.Control[iCurrent+30]=this.pb_4
this.Control[iCurrent+31]=this.pb_anterior
this.Control[iCurrent+32]=this.pb_siguiente
this.Control[iCurrent+33]=this.st_mensaje
this.Control[iCurrent+34]=this.pb_1
this.Control[iCurrent+35]=this.st_6
this.Control[iCurrent+36]=this.dw_operaciones
this.Control[iCurrent+37]=this.sle_busqueda
this.Control[iCurrent+38]=this.tv_escandallo
this.Control[iCurrent+39]=this.cb_2
this.Control[iCurrent+40]=this.cb_4
this.Control[iCurrent+41]=this.st_aplicaciones
this.Control[iCurrent+42]=this.dw_articulos_ant
this.Control[iCurrent+43]=this.pb_bloquear_1
this.Control[iCurrent+44]=this.pb_bloquear_estructura
this.Control[iCurrent+45]=this.pb_2
this.Control[iCurrent+46]=this.pb_3
this.Control[iCurrent+47]=this.dw_imagen
this.Control[iCurrent+48]=this.cb_eliminar3
this.Control[iCurrent+49]=this.st_5
this.Control[iCurrent+50]=this.pb_archivos_modelo
this.Control[iCurrent+51]=this.st_7
this.Control[iCurrent+52]=this.cb_6
this.Control[iCurrent+53]=this.dw_listado_ficha2
this.Control[iCurrent+54]=this.cb_7
this.Control[iCurrent+55]=this.dw_articulo_inicial
this.Control[iCurrent+56]=this.dw_articulo_final
this.Control[iCurrent+57]=this.dw_referencias
this.Control[iCurrent+58]=this.cb_5
this.Control[iCurrent+59]=this.p_imagen
this.Control[iCurrent+60]=this.cb_8
this.Control[iCurrent+61]=this.st_contador
this.Control[iCurrent+62]=this.cb_copiar_parametros
this.Control[iCurrent+63]=this.dw_cajas
this.Control[iCurrent+64]=this.dw_ruta_duplicar
this.Control[iCurrent+65]=this.mle_observaciones
this.Control[iCurrent+66]=this.dw_imagenes_modelo
this.Control[iCurrent+67]=this.dw_articulos_post
this.Control[iCurrent+68]=this.dw_2
this.Control[iCurrent+69]=this.cb_9
this.Control[iCurrent+70]=this.dw_imprimir_seleccionados
this.Control[iCurrent+71]=this.dw_listado_ficha3
end on

on w_mant_altas_intermedios_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_listado)
destroy(this.dw_codestadistico)
destroy(this.dw_caja_articulo)
destroy(this.dw_paletizado)
destroy(this.dw_calidad_altas)
destroy(this.cb_duplicar)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_listado_ficha)
destroy(this.cb_añadir_ver)
destroy(this.cb_eliminar_ver)
destroy(this.st_2)
destroy(this.cb_añadir)
destroy(this.cb_eliminar)
destroy(this.cb_intercalar)
destroy(this.st_3)
destroy(this.dw_aplicaciones)
destroy(this.cb_añadir2)
destroy(this.cb_eliminar2)
destroy(this.cb_intercalar2)
destroy(this.dw_escandallo)
destroy(this.cb_añadir3)
destroy(this.r_2)
destroy(this.r_1)
destroy(this.r_3)
destroy(this.st_50)
destroy(this.cb_duplicar_todo)
destroy(this.dw_versiones)
destroy(this.pb_4)
destroy(this.pb_anterior)
destroy(this.pb_siguiente)
destroy(this.st_mensaje)
destroy(this.pb_1)
destroy(this.st_6)
destroy(this.dw_operaciones)
destroy(this.sle_busqueda)
destroy(this.tv_escandallo)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.st_aplicaciones)
destroy(this.dw_articulos_ant)
destroy(this.pb_bloquear_1)
destroy(this.pb_bloquear_estructura)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.dw_imagen)
destroy(this.cb_eliminar3)
destroy(this.st_5)
destroy(this.pb_archivos_modelo)
destroy(this.st_7)
destroy(this.cb_6)
destroy(this.dw_listado_ficha2)
destroy(this.cb_7)
destroy(this.dw_articulo_inicial)
destroy(this.dw_articulo_final)
destroy(this.dw_referencias)
destroy(this.cb_5)
destroy(this.p_imagen)
destroy(this.cb_8)
destroy(this.st_contador)
destroy(this.cb_copiar_parametros)
destroy(this.dw_cajas)
destroy(this.dw_ruta_duplicar)
destroy(this.mle_observaciones)
destroy(this.dw_imagenes_modelo)
destroy(this.dw_articulos_post)
destroy(this.dw_2)
destroy(this.cb_9)
destroy(this.dw_imprimir_seleccionados)
destroy(this.dw_listado_ficha3)
end on

event closequery;call super::closequery;string v_tabla, v_empresa_mas_tabla
v_tabla = "articulos"

v_empresa_mas_tabla = codigo_empresa+"-"+v_tabla

delete from uti_bloqueo
where usuario = :nombre_usuario
and tabla = :v_empresa_mas_tabla
and titulo = :v_tabla;

if sqlca.sqlcode= 0 then 
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox("Error","Error borrando los bloqueos del usuario actual",StopSign!)
end if

end event

event close;call super::close;
delete from uti_colisiones
where empresa = :codigo_empresa 
and tabla = "articulos"
and usuario = :nombre_usuario 
using sqlca;

if sqlca.sqlcode <> 0 then
	rollback using sqlca;
	messagebox("Error","Error borrando colisiones")
else
	commit using sqlca;
end if

end event

event activate;call super::activate;w_mant_altas_intermedios_nuevo = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_altas_intermedios_nuevo
integer x = 2757
integer y = 356
integer width = 4233
integer height = 1036
integer taborder = 30
string dataobject = "dw_mant_altas_intermedios_nuevo"
boolean minbox = true
boolean border = true
end type

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
str_wt_busquedas_salida resultado

CHOOSE CASE bus_campo
CASE "articulos_formato"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = ""
CASE "articulos_molde"
	bus_titulo     = "AYUDA SELECCION DE MOLDES"
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro     = "activo = 'S'"
CASE "articulos_marco"
	bus_titulo     = "AYUDA SELECCION DE MARCOS"
	bus_datawindow = "dw_ayuda_prodmarcos"
	bus_filtro     = ""	
CASE "articulos_uso"
	bus_titulo     = "AYUDA SELECCION DE USOS"
	bus_datawindow = "dw_ayuda_almusos"
	bus_filtro     = ""		
CASE "articulos_plato_sup"
	bus_titulo     = "VENTANA SELECCION DE PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "molde = '" +string(this.object.articulos_molde[this.GetRow()])+"' and  tipo = 'Superior'"
CASE "articulos_plato_inf"
	bus_titulo     = "AYUDA SELECCION PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "molde = '" +string(this.object.articulos_molde[this.GetRow()])+"' and  tipo = 'Inferior'"
CASE "articulos_costilla"
	bus_titulo     = "AYUDA SELECCION COSTILLA"
	bus_datawindow = "dw_ayuda_costilla"
	bus_filtro     = ""

CASE "articulos_tipo_ubicacion"
	bus_titulo     = "AYUDA SELECCION UBICACION"
	bus_datawindow = "dw_ayuda_tipo_ubicacion"
	bus_filtro     = " filtro_articulo = 'S'"
	
CASE "articulos_relieve"
	
	bus_titulo     = "VENTANA SELECCION DE RELIEVES "
 	bus_datawindow = "dw_ayuda_art_tipomoldura"
	bus_filtro= ""
	/*
	Open(wtc_ayuda_busqueda_relieves)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado >= 2 then
		this.object.articulos_relieve[this.getrow()] = resultado.valores[1]
		this.object.art_tipomoldura_descripcion[this.getrow()] = resultado.valores[2]
	end if
	*/
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::key;String coleccion, modelo, uso
valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
str_wt_busquedas_salida resultado

CHOOSE CASE bus_campo
CASE "articulos_formato"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = ""
CASE "articulos_molde"
	bus_titulo     = "AYUDA SELECCION DE MOLDES"
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro     = "activo = 'S'"
CASE "articulos_marco"
	bus_titulo     = "AYUDA SELECCION DE MARCOS"
	bus_datawindow = "dw_ayuda_prodmarcos"
	bus_filtro     = ""		
CASE "articulos_uso"
	bus_titulo     = "AYUDA SELECCION DE USOS"
	bus_datawindow = "dw_ayuda_almusos"
	bus_filtro     = ""			
CASE "articulos_plato_sup"
	bus_titulo     = "VENTANA SELECCION DE PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "molde = '" +string(this.object.articulos_molde[this.GetRow()])+"' and  tipo = 'Superior'"
CASE "articulos_plato_inf"
	bus_titulo     = "AYUDA SELECCION PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "molde = '" +string(this.object.articulos_molde[this.GetRow()])+"' and  tipo = 'Inferior'"
CASE "articulos_costilla"
	bus_titulo     = "AYUDA SELECCION COSTILLA"
	bus_datawindow = "dw_ayuda_costilla"
	bus_filtro     = ""

CASE "articulos_tipo_ubicacion"
	bus_titulo     = "AYUDA SELECCION UBICACION"
	bus_datawindow = "dw_ayuda_tipo_ubicacion"
	bus_filtro     = " filtro_articulo = 'S'"

CASE "articulos_relieve"

	bus_titulo     = "VENTANA SELECCION DE RELIEVES "
 	bus_datawindow = "dw_ayuda_art_tipomoldura"
	bus_filtro     = "" 
		/*
	if key =  keyEnter! then
		Open(wtc_ayuda_busqueda_relieves)
		resultado = Message.PowerObjectParm
		if resultado.resultado = -1 then
			MessageBox("Error en la creación de la búsqueda",resultado.error)
		elseif resultado.resultado >= 2 then
			this.object.articulos_relieve[this.getrow()] = resultado.valores[1]
			this.object.art_tipomoldura_descripcion[this.getrow()] = resultado.valores[2]
		end if
	end if
	
	*/
CASE "articulos_imagen_origen"	
	/*
		if key =  keyEnter! then
			uso = this.object.articulos_uso[dw_1.getrow()]
			modelo = this.object.articulos_modelo_origen[dw_1.getrow()]
			if uso <> "3" then
				MessageBox("Atención", "Solo se debe indicar una referencia de imagen para el encajado")
				return
			end if
			if isnull(modelo) or modelo = "" then
				MessageBox("Atención", "Debe indicar previamente el código del modelo.")
				return
			end if
			SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
			dw_imagenes_modelo.settransobject(SQLCA)
			dw_imagenes_modelo.retrieve(codigo_empresa, coleccion, modelo)
			dw_imagenes_modelo.visible = true
		end if	
		*/
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key
end event

event dw_1::itemchanged;call super::itemchanged;string v_juegopantallas, v_factormp, operacion
String uso, coleccion, modelo

IF dwo.Name = "articulos_formato" THEN
	dw_1.object.formatos_abreviado[row] = f_nombre_formato_Abr(codigo_empresa, data)
	dw_1.object.formatos_descripcion[row] = f_nombre_formato(codigo_empresa, data)

END IF

IF dwo.Name = "articulos_molde" THEN
	dw_1.object.prodmoldes_descripcion[row] = f_nombre_molde(codigo_empresa, data)
END IF
IF dwo.Name = "articulos_marco" THEN
	dw_1.object.prodmarcos_descripcion[row] = f_nombre_marco(codigo_empresa,data)
END IF
IF dwo.Name = "articulos_plato_sup" THEN
	dw_1.object.prodplatos_descripcion[row] = f_nombre_plato(codigo_empresa, data)
END IF
IF dwo.Name = "articulos_plato_inf" THEN
	dw_1.object.prodplatos_descripcion_1[row] = f_nombre_plato(codigo_empresa,data)
END IF
IF dwo.Name = "articulos_costilla" THEN
	dw_1.object.costilla_descripcion[row] = f_nombre_costilla(codigo_empresa,data)
END IF

IF dwo.Name = "articulos_relieve" THEN
	dw_1.object.art_tipomoldura_descripcion[row] = f_nombre_tipomoldura2(codigo_empresa, data)
END IF

IF dwo.Name = "articulos_tipo_ubicacion" THEN
	dw_1.object.tipo_ubicacion_descripcion[row] = f_nombre_tipo_ubicacion(codigo_empresa, data)
END IF

if dwo.Name =  "articulos_imagen_origen" then
	/*
	if data <> "" then
		uso = this.object.articulos_uso[dw_1.getrow()]
		modelo = this.object.articulos_modelo_origen[dw_1.getrow()]
		if uso <> "3" then
			MessageBox("Atención", "Solo se debe indicar una referencia de imagen para el encajado")
			dwo.Primary[row] = ''
			return 2
		end if
		if isnull(modelo) or modelo = "" then
			MessageBox("Atención", "Debe indicar previamente el código del modelo.")
			dwo.Primary[row] = ''
			return 2
		end if
		SELECT coleccion INTO :coleccion FROM modelo WHERE empresa = :codigo_empresa AND modelo = :modelo;
		dw_imagenes_modelo.settransobject(SQLCA)
		dw_imagenes_modelo.retrieve(codigo_empresa, coleccion, modelo)
		dw_imagenes_modelo.visible = true
		
		dwo.Primary[row] = ''
		return 2
	end if
	*/
end if

long i

dw_1.accepttext()
if dw_operaciones.rowcount() > 0 then
	for i = 1 to dw_operaciones.rowcount()
		dw_operaciones.object.art_ver_operaciones_formato[i]  = dw_1.object.articulos_formato[row] 
		dw_operaciones.object.formatos_descripcion[i]  = dw_1.object.formatos_descripcion[row] 
	next
end if
end event

event dw_1::retrieveend;call super::retrieveend;p_imagen.PictureName = ""
IF dw_1.GetRow() > 0 then
	if not f_cargar_imagen_pieza() then
		p_imagen.visible = true
		p_imagen.PictureName = f_cargar_imagen_nuevo(string(dw_1.object.articulos_codigo_pantallas[dw_1.GetRow()]))
	else
		p_imagen.visible = false
	end if
else
	dw_imagen.visible = false
	p_imagen.visible = false
END IF

end event

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_articulos_conjunto_nuevo"

CHOOSE CASE dwo.Name
	
CASE 'mantenimiento_molde'
   lstr_param.s_argumentos[2]=dw_1.object.articulos_molde[row]
	OpenWithParm(wi_mant_prodmoldes,lstr_param)
CASE 'mantenimiento_marco'
   lstr_param.s_argumentos[2]=dw_1.object.articulos_marco[row]
	OpenWithParm(wtc_mant_marcos,lstr_param)
CASE 'mantenimiento_plato_sup'
   lstr_param.s_argumentos[2]=dw_1.object.articulos_plato_sup[row]
   OpenWithParm(wi_mant_prodplatos,lstr_param)  
CASE 'mantenimiento_plato_inf'
   lstr_param.s_argumentos[2]=dw_1.object.articulos_plato_inf[row]
   OpenWithParm(wi_mant_prodplatos,lstr_param)
CASE 'mantenimiento_relieve'
   lstr_param.s_argumentos[2]=dw_1.object.articulos_relieve[row]
  OpenWithParm(w_mant_art_tipomoldura,lstr_param)  
CASE 'mantenimiento_formato'
   lstr_param.s_argumentos[2]=dw_1.object.articulos_formato[row]
   OpenWithParm(wi_mant_formatos,lstr_param)
CASE 'p_ean'
	long   ll_nuevo_ean,ll_nuevo_ean_sga
	string ls_familia,ls_promocion,ls_prefijo_ean13,ls_prefijo_ean13_sga,ls_nuevo_ean,ls_ean13,ls_nuevo_ean_sga,ls_ean13_sga
	int    li_longitud_ean,li_longitud_prefijo,li_longitud_sufijo
	
	ls_familia   = dw_1.object.articulos_familia[row]
	ls_promocion = dw_1.object.articulos_promocion[row]
	
	if isnull(ls_familia) then ls_familia = ""
	
	if trim(ls_familia) <> "" or ls_promocion = 'S' then	
		/*
		ls_prefijo_ean13     = "8434768"
		ls_prefijo_ean13_sga = "29"	
		*/
		if ls_promocion <> 'S' then
			SELECT ltrim(rtrim(isnull(familias.prefijo_ean13,''))), 
					 ltrim(rtrim(isnull(familias.prefijo_ean13_sga,''))) 
			INTO   :ls_prefijo_ean13,
					 :ls_prefijo_ean13_sga 
			FROM   familias 
			WHERE  familias.empresa = :codigo_empresa
			AND    familias.codigo  = :ls_familia;
		else
			//La promocion solo lleva ean13_sga con codigo interno
			ls_prefijo_ean13     = ''
			ls_prefijo_ean13_sga = '29'	
		end if
		
		li_longitud_ean     = 12
		
		ls_ean13     = dw_1.object.articulos_ean13[row]
		ls_ean13_sga = dw_1.object.articulos_ean13_sga[row]
		
		if isnull(ls_ean13) then ls_ean13 = ""
		if isnull(ls_ean13_sga) then ls_ean13_sga = ""		
							
		if ls_ean13 = "" and trim(ls_prefijo_ean13) <> "" then	
			li_longitud_prefijo = len(ls_prefijo_ean13)
			li_longitud_sufijo  = li_longitud_ean - li_longitud_prefijo
			
			select isnull(max(convert(dec(12,0),substring(articulos.ean13,(:li_longitud_prefijo +1),:li_longitud_sufijo))),0) + 1
			into   :ll_nuevo_ean
			from   articulos
			where  articulos.empresa = :codigo_empresa
			and    isnull(articulos.ean13,'') <> ''
			and    substring(articulos.ean13,1,:li_longitud_prefijo) = :ls_prefijo_ean13;	
			
			ls_nuevo_ean = ls_prefijo_ean13+string(ll_nuevo_ean,left("000000000000",li_longitud_sufijo))
			ls_nuevo_ean = f_calcula_ean13(ls_nuevo_ean)
			
			this.object.articulos_ean13[row] = ls_nuevo_ean
		end if	
		
		if ls_ean13_sga = "" and trim(ls_prefijo_ean13_sga) <> "" then
			if ls_prefijo_ean13 = ls_prefijo_ean13_sga then
				dw_1.object.articulos_ean13_sga[row] = dw_1.object.articulos_ean13[row]
			else
				li_longitud_prefijo = len(ls_prefijo_ean13_sga)
				li_longitud_sufijo  = li_longitud_ean - li_longitud_prefijo			

				select isnull(max(convert(dec(12,0),substring(articulos.ean13_sga,(:li_longitud_prefijo +1),:li_longitud_sufijo))),0) + 1
				into   :ll_nuevo_ean_sga
				from   articulos
				where  articulos.empresa = :codigo_empresa
				and    isnull(articulos.ean13_sga,'') <> ''
				and    substring(articulos.ean13_sga,1,:li_longitud_prefijo) = :ls_prefijo_ean13_sga;	
								
//				select isnull(max(convert(dec(5,0),substring(articulos.ean13_sga,8,5))),0) + 1
//				into   :ls_nuevo_ean_sga
//				from   articulos
//				where  articulos.empresa = '1'
//				and    isnull(articulos.ean13_sga,'') <> ''
//				and    substring(articulos.ean13_sga,1,7) = :ls_prefijo_ean13_sga;	
				
				ls_nuevo_ean_sga = ls_prefijo_ean13_sga+string(ll_nuevo_ean_sga,left("000000000000",li_longitud_sufijo))
				ls_nuevo_ean_sga = f_calcula_ean13(ls_nuevo_ean_sga)
				
				this.object.articulos_ean13_sga[row] = ls_nuevo_ean_sga
			end if
		end if		
	else
		messagebox("¡Error!","No se puede asignar un EAN13 sin indicar la familia del articulo.")
	end if

	
END CHOOSE
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_altas_intermedios_nuevo
integer x = 2871
integer y = 128
integer width = 270
integer textsize = -9
fontcharset fontcharset = ansi!
long textcolor = 0
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_altas_intermedios_nuevo
integer x = 5847
integer y = 88
integer width = 329
integer height = 108
end type

event cb_insertar::clicked;int total
integer li_rc 
string motivo, controles, campo, uso, tipo_ubi
long numero, i, j, k, l, m, fila
datawindow dato
boolean falta_campo
string v_g2, v_g3, v_formato
long fila_version, fila_operacion, fila_aplicacion, aceptados
dec coste_mp_operacion, costePacking 
string ver, operacion, referencia_lab, modelo_origen, pieza_origen, cliente_pieza, coleccion
Datetime ahora = Datetime(today())
Long total_imagenes, total_imagenes2, total_imagenes3
String articulo, ruta, fichero
int piezasCaja
dec precioCaja
int rtn




if mle_observaciones.visible then
	messagebox("Atención", "Debe cerrar las observaciones antes de grabar")
	return
end if

dw_versiones.AcceptText()
dw_operaciones.AcceptText()
dw_aplicaciones.AcceptText()
dw_escandallo.AcceptText()
dw_1.AcceptText()


fila_version = dw_versiones.getrow()
fila_operacion = dw_operaciones.getrow()
fila_aplicacion = dw_aplicaciones.getrow()

dw_versiones.setredraw ( false)
dw_operaciones.setredraw ( false)
dw_aplicaciones.setredraw ( false)




IF dw_1.rowcount() > 0 THEN
	falta_campo = false
	if isnull(dw_1.object.articulos_codigo_pantallas[1]) or dw_1.object.articulos_codigo_pantallas[1] = '' then
		dw_1.object.articulos_codigo_pantallas[1] = 	dw_1.object.articulos_referencia_laboratorio[1]
	end if
	dw_1.accepttext()
	i = dw_1.getrow()
	dw_codestadistico.accepttext()
	j = dw_codestadistico.getrow()
	dw_caja_articulo.accepttext()
	k = dw_caja_articulo.getrow()
	dw_paletizado.accepttext()
	k = dw_paletizado.getrow()
	
	// DW_1
	IF IsNull(dw_1.object.articulos_descripcion[i]) or Trim(String(dw_1.object.articulos_descripcion[i]))="" THEN
		  campo="articulos_descripcion"
		  motivo  = "(Campo Obligatorio) Introduzca la descripción."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_formato[i]) or Trim(String(dw_1.object.articulos_formato[i]))="" THEN
		  campo="articulos_formato"
		  motivo  = "(Campo Obligatorio) Introduzca el formato."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_uso[i]) or Trim(String(dw_1.object.articulos_uso[i]))="" THEN
		  campo="articulos_uso"
		  motivo  = "(Campo Obligatorio) Introduzca el USO."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.articulos_tipo_ubicacion[i]) or Trim(String(dw_1.object.articulos_tipo_ubicacion[i]))="" THEN
		if String(dw_1.object.articulos_uso[i]) = "3" then
			  campo="articulos_tipo_ubicacion"
			  motivo  = "(Campo Obligatorio) Introduzca la UBICACION."
			  dato = dw_1
			  numero = 1
			  falta_campo = True
		else
			dw_1.object.articulos_tipo_ubicacion[i] = '3'	
			dw_1.object.tipo_ubicacion_descripcion[i] = f_nombre_tipo_ubicacion(codigo_empresa, '3')
		end if
	END IF
	
	IF String(dw_1.object.articulos_uso[i]) = "3" then
		if not IsNull(dw_1.object.articulos_pieza_origen[i]) or Trim(String(dw_1.object.articulos_pieza_origen[i])) <> "" THEN
			dw_1.object.articulos_pieza_origen[i] = ""
		end if
		if not IsNull(dw_1.object.articulos_prueba_origen[i]) or Trim(String(dw_1.object.articulos_prueba_origen[i])) <> "" THEN
			dw_1.object.articulos_prueba_origen[i] = ""
		end if
	end if
	
	if not falta_campo then
		referencia_lab = Trim(String(dw_1.object.articulos_referencia_laboratorio[i]))
		modelo_origen = Trim(String(dw_1.object.articulos_modelo_origen[i]))
		if isnull(referencia_lab) or referencia_lab = "" then
			if isnull(modelo_origen) or modelo_origen = "" then
				//Se puede dejar en blanco todo (solo en bases)
				if not ftc_articulo_base(sle_valor.text) then
					campo="articulos_modelo_origen"
					motivo  = "(Campo Obligatorio) Debe introducir una referencia de laboratorio."
					dato = dw_1
					numero = 1
					falta_campo = True
				end if
			else
				//Comprobamos la referencia nueva
				pieza_origen = dw_1.object.articulos_pieza_origen[i]
				//PUEDE SER NULL EN ENCAJADOS Y EN BASES SOLO
				if String(dw_1.object.articulos_uso[i]) = "2" then
					IF IsNull(dw_1.object.articulos_pieza_origen[i]) or Trim(String(dw_1.object.articulos_pieza_origen[i]))="" THEN
						  campo="articulos_pieza_origen"
						  motivo  = "(Campo Obligatorio) Introduzca la Pieza del Modelo de procedencia del articulo."
						  dato = dw_1
						  numero = 1
						  falta_campo = True
					ELSEIF IsNull(dw_1.object.articulos_prueba_origen[i]) or Trim(String(dw_1.object.articulos_prueba_origen[i]))="" THEN
						  campo="articulos_prueba_origen"
						  motivo  = "(Campo Obligatorio) Introduzca la Prueba de laboratorio de procedencia del articulo."
						  dato = dw_1
						  numero = 1
						  falta_campo = True
					END IF
				end if
			end if
		else
			if isnull(modelo_origen) or modelo_origen = "" then
				//Comprobamos la referencia antigua
				//PUEDE SER NULL SOLO EN BASES
				if String(dw_1.object.articulos_uso[i]) <> "1" then
					IF IsNull(dw_1.object.articulos_version_laboratorio[i]) or Trim(String(dw_1.object.articulos_version_laboratorio[i]))="" THEN
						  campo="articulos_version_laboratorio"
						  motivo  = "(Campo Obligatorio) Introduzca la Prueba de laboratorio de procedencia del articulo."
						  dato = dw_1
						  numero = 1
						  falta_campo = True
					END IF
				end if
			else
				//NO PUEDEN DARSE LAS DOS REFERENCIAS (Antigua y nueva a la vez)
				campo="articulos_referencia_laboratorio"
				motivo  = "No puede introducir las dos referencias de laboratorio para un mismo artículo. Indique Modelo / Pieza / Prueba para modelos del sistema nuevo."
				dato = dw_1
				numero = 1
				falta_campo = True
			end if
		end if
	end if
	
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dato.setfocus()
	  dato.SetColumn(campo)
	  return 1
	END IF
	
	//f_calculos_caja()
END IF


//HACEMOS ESTO PARA RELLENAR LAS ALTAS DE LOS ARTÍCULOS DE COMPRA INTERMEDIOS CON VALORES POR DEFECTO

dw_1.accepttext()

uso = dw_1.object.articulos_uso[dw_1.getrow()]
tipo_ubi = dw_1.object.articulos_tipo_ubicacion[dw_1.getrow()]

if uso = '2' and tipo_ubi = '7' then
	
	

	
	if dw_versiones.rowcount() = 0 then
			
		fila = dw_versiones.insertrow(0)
			
		dw_versiones.object.empresa[fila] = codigo_empresa
		dw_versiones.object.articulo[fila] = sle_valor.text
		dw_versiones.object.version[fila] = '1'
		dw_versiones.object.tipo_version[fila] = 'P'
		dw_versiones.object.descripcion[fila] = 'ÚNICA'
		dw_versiones.object.base[fila] = '0'
			
	end if
	
	if dw_escandallo.rowcount() = 0 then
		
		fila = dw_escandallo.insertrow(0)
		
		dw_escandallo.object.art_escandallo_empresa[fila] = codigo_empresa
		dw_escandallo.object.art_escandallo_articulo[fila] = sle_valor.text
		dw_escandallo.object.art_escandallo_version[fila] = '1'
		dw_escandallo.object.art_escandallo_articulo_ant[fila] = '0'
		dw_escandallo.object.art_escandallo_factor[fila] = 1
		
	end if
	
	if dw_operaciones.rowcount() = 0 then
		
		fila = dw_operaciones.insertrow(0)
		
		dw_operaciones.object.empresa[fila] = codigo_empresa
		dw_operaciones.object.articulo[fila] = sle_valor.text
		dw_operaciones.object.version[fila] = '1'
		dw_operaciones.object.operacion[fila] = '1'
		dw_operaciones.object.orden[fila] = '1'
		dw_operaciones.object.art_ver_operaciones_formato[fila] = dw_1.object.articulos_formato[dw_1.getrow()]
		dw_operaciones.object.art_ver_operaciones_factor[fila] = 1
		dw_operaciones.object.formatos_descripcion[fila] = dw_1.object.formatos_abreviado[dw_1.getrow()]
		dw_operaciones.object.tipo_operacion[fila] = '27'
		
	end if
	
	
	if dw_aplicaciones.rowcount() = 0 then
		
		fila = dw_operaciones.insertrow(0)
		
		dw_aplicaciones.object.empresa[fila] = codigo_empresa
		dw_aplicaciones.object.articulo[fila] = sle_valor.text
		dw_aplicaciones.object.operacion[fila] = dw_operaciones.object.operacion[dw_operaciones.getrow()]
		dw_aplicaciones.object.version[fila] = '1'
		dw_aplicaciones.object.contadoraplicacion[fila] = '1'
		dw_aplicaciones.object.orden[fila] = '1'
		dw_aplicaciones.object.tipoaplicacion[fila] = '19'
	
	end if
		
end if
	
///////////////////////////////////////////////////////////////////////////////////////////





if dw_versiones.rowcount() > 0 then 
	if dw_versiones.object.base[dw_versiones.getrow()] <> '' and not isnull (dw_versiones.object.base[dw_versiones.getrow()]) and dw_escandallo.rowcount() < 1 then
		cb_añadir3.triggerevent(clicked!)
		dw_escandallo.object.art_escandallo_articulo_ant[1] = dw_versiones.object.base[dw_versiones.getrow()] 
		dw_escandallo.object.articulos_descripcion[1] = dw_versiones.object.articulos_descripcion[dw_versiones.getrow()] 
	end if
end if

// Calculo del coste de las cajas
if dw_1.object.articulos_uso[dw_1.GetRow()] = '3' then
	if dw_operaciones.RowCount() > 0 then
		dw_operaciones.object.art_ver_operaciones_coste_packing[dw_operaciones.GetRow()] = f_calculo_coste_packing (codigo_empresa, sle_valor.text)
	end if
end if

// Calculo del coste de los articulos de compras
if dw_1.object.articulos_uso[dw_1.GetRow()] = '3' then
	if dw_operaciones.RowCount() > 0 then
		dw_operaciones.object.art_ver_operaciones_coste_packing[dw_operaciones.GetRow()] = f_calculo_coste_packing (codigo_empresa, sle_valor.text)
	end if
end if


rtn = dw_codestadistico.update()
if rtn = 1 then
	rtn = dw_caja_articulo.update()
	if rtn = 1 then
		dw_paletizado.update()
		if rtn = 1 then
			dw_calidad_altas.update()
			if rtn = 1 then
				dw_versiones.update()
				if rtn = 1 then
					dw_operaciones.update()
					if rtn = 1 then
						dw_escandallo.update()
						if rtn = 1 then
							dw_2.update()
						end if
					end if
				end if
			end if
		end if
	end if
end if




//  Añado esto para recalcular el coste de mp si se modifica algún dato de las aplicaciones.
if rtn = 1 and dw_aplicaciones.rowcount()  > 0 then
	rtn = dw_aplicaciones.update()
	if rtn = 1 then
		ver = dw_versiones.object.version[dw_versiones.getrow()]
		operacion = dw_operaciones.object.operacion[dw_operaciones.getrow()]
		
		coste_mp_operacion = f_calculo_mp_operacion (codigo_empresa, sle_Valor.text, operacion, ver)
	end if
end if

//actualización estado
if rtn = 1 and not isnull(modelo_origen) and modelo_origen <> "" and not isnull(pieza_origen) and pieza_origen <> "" then
	SELECT modelo_pieza.cliente, modelo.coleccion 
	INTO :cliente_pieza, :coleccion 
	FROM modelo_pieza 
	INNER JOIN modelo ON modelo_pieza.empresa = modelo.empresa 
		AND modelo_pieza.modelo = modelo.modelo 
	WHERE modelo_pieza.empresa = :codigo_empresa 
		AND modelo_pieza.modelo = :modelo_origen 
		AND modelo_pieza.codigo_lab = :pieza_origen 
	USING SQLCA;
	
	SELECT ISNULL(COUNT(*), 0 ) 
	INTO :aceptados 
	FROM deshistorico 
	WHERE coleccion = :coleccion 
		AND estado LIKE '%Aceptado%'
	USING SQLCA;
	
	if aceptados < 1 then
		//aceptamos el trabajo del cliente a fecha de hoy
		UPDATE descoleccionsol 
		SET estado = 'Aceptado' 
		WHERE empresa = :codigo_empresa 
			AND codigo = :coleccion 
		USING SQLCA;
			
		if sqlca.sqlcode <> 0 then
			rtn = -1
		else
			UPDATE deshistorico 
			SET estado = 'Aceptado', f_resp = :ahora 
			WHERE empresa = :codigo_empresa 
				AND coleccion = :coleccion 
				AND cliente = :cliente_pieza
			USING SQLCA;
			if sqlca.sqlcode <> 0 then
				rtn = -1
			else
				UPDATE deshistorico 
				SET estado = 'Rechazado', f_resp = :ahora 
				WHERE empresa = :codigo_empresa 
					AND coleccion = :coleccion 
					AND cliente <> :cliente_pieza 
					and (estado = 'Pendiente' or estado = 'Reservado')
				USING SQLCA;
				if sqlca.sqlcode <> 0 then
					rtn = -1
				end if
			end if
		end if
	end if
end if

Call super::clicked


if reg_insertado = true then
	//insertamos la imagen del modelo
	total_imagenes = 0
	articulo = String(sle_valor.text)
	modelo_origen = Trim(String(dw_1.object.articulos_modelo_origen[dw_1.getrow()]))
	pieza_origen = Trim(String(dw_1.object.articulos_pieza_origen[dw_1.getrow()]))
	if not isnull(articulo) and articulo <> "" and not isnull(modelo_origen) and modelo_origen <> "" then
		SELECT COUNT(*) INTO :total_imagenes FROM articulos_imagen_encajado WHERE empresa = :codigo_empresa AND articulo = :articulo using sqlca;
		SELECT COUNT(*) INTO :total_imagenes2 FROM modelo_pieza_archivo WHERE empresa = :codigo_empresa AND pieza = :pieza_origen using sqlca;
		SELECT COUNT(*) INTO :total_imagenes3 FROM modelo_archivo_expo WHERE empresa = :codigo_empresa AND modelo = :modelo_origen AND produccion = 1 using sqlca;
		if total_imagenes = 0 then
			if not isnull(pieza_origen) and pieza_origen <> "" then
				SELECT TOP 1 ruta, fichero INTO :ruta, :fichero FROM modelo_pieza_archivo WHERE empresa = :codigo_empresa AND pieza = :pieza_origen using sqlca;
			else
				SELECT ruta, fichero INTO :ruta, :fichero FROM modelo_archivo_expo WHERE empresa = :codigo_empresa AND modelo = :modelo_origen AND produccion = 1 using sqlca;
			end if
			fichero = trim(fichero)
			if (total_imagenes2 + total_imagenes3) > 0 then
				INSERT INTO articulos_imagen_encajado (empresa, articulo, codigo, modelo, pieza, ruta, fichero, produccion, fecha_modificacion) 
				VALUES (:codigo_empresa, :articulo, '1', :modelo_origen, :pieza_origen, :ruta, :fichero, 1, :ahora) using sqlca;
				if sqlca.sqlcode <> 0 then
					rtn = -1
				end if
			end if
		end if		
	end if
		
	delete from uti_colisiones
	where empresa = :codigo_empresa 
	and tabla = "articulos"
	and usuario = :nombre_usuario
	using sqlca;
	if sqlca.sqlcode <> 0 then
		rtn = -1
	end if
	
end if

if rtn = 1 then 
	commit using sqlca;
else
	rollback using sqlca;
end if

dw_versiones.setRow(fila_version)
dw_versiones.scrollToRow (fila_version)
dw_versiones.Setfocus()

if dw_operaciones.rowcount() > fila_operacion then
	dw_operaciones.setRow(fila_operacion + 1)
	dw_operaciones.scrollToRow (fila_operacion +1)
else
	dw_operaciones.setRow(fila_operacion)	
	dw_operaciones.scrollToRow (fila_operacion)
end if
	

dw_operaciones.Setfocus()

dw_aplicaciones.setRow(fila_aplicacion)
dw_aplicaciones.scrollToRow (fila_aplicacion)
dw_aplicaciones.Setfocus()

dw_versiones.setredraw ( true)
dw_operaciones.setredraw ( true)
dw_aplicaciones.setredraw ( true)

tv_escandallo.setfocus()


end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_altas_intermedios_nuevo
integer x = 5321
integer y = 88
integer width = 329
integer height = 108
end type

event cb_borrar::clicked;string valor, modelo, ruta_archivos_exposicion, sel
boolean exito
Long i, j, numero_imagenes, numero_tipos

str_ventana_alerta parametros
string botones[2]
Int borrar_accion

Datastore imagenes, tipos

parametros.titulo = "Atención"
parametros.subtitulo = "Borrar registro"
parametros.mensaje = "¿Seguro que quieres borrar este artículo, "+nombre_usuario+"?"
parametros.tipo = 1
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar_accion = Int(Message.DoubleParm)

valor = sle_valor.text
if borrar_accion = 1 then

	CALL Super::clicked
	
	exito = true
	
	if not cb_borrar.enabled then
		delete from art_codestadistico 
		where empresa = :codigo_empresa 
		and codigo = :valor;
		
		if SQLCA.SQLCode <> 0 then
			exito = false
		else
			delete from art_escandallo
			where empresa = :codigo_empresa 
			and articulo = :valor or articulo_ant = :valor;
			if SQLCA.SQLCode <> 0 then
				exito = false
			else
				delete from almartcajas
				where empresa = :codigo_empresa 
				and articulo = :valor;
				if SQLCA.SQLCode <> 0 then
					exito = false
				else
					delete from palarticulo
					where empresa = :codigo_empresa 
					and articulo = :valor;
					if SQLCA.SQLCode <> 0 then
						exito = false
					else
						delete from art_versiones
						where empresa = :codigo_empresa 
						and articulo = :valor;
						if SQLCA.SQLCode <> 0 then
							exito = false
						else
							delete from almartcal
							where empresa = :codigo_empresa 
							and articulo = :valor;
							if SQLCA.SQLCode <> 0 then
								exito = false
							else
								delete from art_ver_operaciones
								where empresa = :codigo_empresa 
								and articulo = :valor;
								if SQLCA.SQLCode <> 0 then
									exito = false
								else
									delete from art_ver_op_aplicaciones
									where empresa = :codigo_empresa 
									and articulo = :valor;
									if SQLCA.SQLCode <> 0 then
										exito = false
									else
										delete from art_codestadistico
										where empresa = :codigo_empresa 
										and codigo = :valor;
										if SQLCA.SQLCode <> 0 then
											exito = false
										else
											//Borrar imágenes
											
											delete from art_codestadistico
											where empresa = :codigo_empresa 
											and codigo = :valor;
											if SQLCA.SQLCode <> 0 then
												exito = false
											else
												SELECT ruta_archivos_exposicion INTO :ruta_archivos_exposicion FROM empresas WHERE empresa = :codigo_empresa;
												
												//imágenes articulo directamente introducidas (no relacionadas con el modelo)
												sel = "SELECT ruta, fichero FROM articulos_imagen_encajado WHERE empresa = '"+codigo_empresa+"' AND articulo = '"+valor+"' AND modelo IS NULL"
												f_cargar_cursor_trans (SQLCA,  sel,  imagenes)
												numero_imagenes = imagenes.RowCount()
												For i = 1 To numero_imagenes
													FileDelete(ruta_archivos_exposicion + imagenes.object.ruta[i] + "\" + imagenes.object.fichero[i])													
													//Miniaturas
													sel = "SELECT * FROM archivo_resolucion WHERE empresa = '"+codigo_empresa+"'"
													f_cargar_cursor_trans (SQLCA,  sel,  tipos)
													numero_tipos = tipos.RowCount()
													For j = 1 To numero_tipos
														FileDelete(ruta_archivos_exposicion + imagenes.object.ruta[i] + "\" + tipos.object.tamanyo[j] + "\" + imagenes.object.fichero[i])
													Next
												Next 
												
												Destroy imagenes
												Destroy tipos
												
												DELETE FROM articulos_imagen_encajado 
												WHERE empresa = :codigo_empresa AND articulo = :valor USING SQLCA;
											end if
										end if
									end if
								end if
							end if
						end if
					end if
				end if
		
			end if
		end if
		
		if exito then
			commit;
			dw_1.reset()
			dw_versiones.reset()
			dw_operaciones.reset()
			dw_escandallo.reset()
			dw_aplicaciones.reset()
		else
			rollback;
		end if
	end if
end if



end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_altas_intermedios_nuevo
integer x = 3127
integer y = 112
integer height = 96
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_articulos"
ue_titulo      = "AYUDA SELECCION DE ARTÍCULOS"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_altas_intermedios_nuevo
integer x = 6185
integer y = 88
integer width = 329
integer height = 108
end type

event cb_salir::clicked;if insercion = "S"  then
	parent.triggerevent(closequery!)
end if

CALL Super::clicked
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_altas_intermedios_nuevo
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_altas_intermedios_nuevo
integer x = 3040
integer y = 20
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_altas_intermedios_nuevo
integer width = 6912
integer height = 64
end type

type pb_calculadora from u_calculadora within w_mant_altas_intermedios_nuevo
integer x = 3397
integer y = 112
integer width = 123
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;/*
long iteraciones, v_codigo
boolean exito
string v_tabla, v_titulo, v_empresa_mas_tabla
datetime v_fecha

v_tabla = "articulos"
v_titulo = v_tabla
v_fecha = datetime (today())

v_empresa_mas_tabla = codigo_empresa+"-"+v_tabla

connect using sqlca;

delete from uti_bloqueo
where usuario = :nombre_usuario
and tabla = :v_tabla
and titulo = "articulos";

if sqlca.sqlcode= 0 then 
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox("Error","Error borrando los bloqueos del usuario actual",StopSign!)
end if
// Fin de borrar bloqueos del usuario actual

select max (convert(integer, codigo))
into :v_codigo
from articulos 
where empresa = :codigo_empresa;

v_codigo ++


DO WHILE iteraciones < 10 and not exito
	INSERT INTO uti_bloqueo (tabla, codigo, titulo, fecha, usuario)
					VALUES (:v_empresa_mas_tabla, :v_codigo, :v_titulo, :v_fecha, :nombre_usuario);
	if sqlca.sqlcode= 0 then 
		commit;
		exito = true
	else
		rollback;
		iteraciones ++
		v_codigo ++
	end if
LOOP


if iteraciones >= 10 then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=string(v_codigo)
	dw_1.triggerEvent("clicked")
end if
*/

Long codigo
codigo = f_colisiones2(codigo_empresa, "articulos", "codigo", "", false)

if codigo = 0  then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=String(codigo)
	dw_1.triggerEvent("clicked")
end if

end event

type dw_listado from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 2981
integer y = 3104
integer width = 581
integer height = 348
boolean bringtotop = true
string dataobject = "dw_etiqueta_pantalla"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_codestadistico from u_datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 5518
integer y = 260
integer width = 818
integer height = 92
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_codestadistico_intermedios"
boolean border = false
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if


If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event itemchanged;
IF dwo.Name = "art_codestadistico_tm" THEN
	dw_codestadistico.object.art_tipomoldura_descripcion[row] = f_nombre_tipomoldura(codigo_empresa, data)
END IF

end event

event rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "art_codestadistico_tm"
	bus_titulo     = "AYUDA SELECCION DE RELIEVES"
	bus_datawindow = "dw_ayuda_art_tipomoldura_abr"
	bus_filtro     = ""

CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "art_codestadistico_tm"
	bus_titulo     = "AYUDA SELECCION DE RELIEVES"
	bus_datawindow = "dw_ayuda_art_tipomoldura_abr"
	bus_filtro     = ""

CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_caja_articulo from u_datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 2414
integer y = 3104
integer width = 1929
integer height = 272
integer taborder = 250
boolean bringtotop = true
string dataobject = "dw_caja_articulo"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if




end event

event itemchanged;
IF dwo.Name = "almartcajas_caja" THEN
	dw_caja_Articulo.object.almcajas_descripcion[row] = f_nombre_caja ( codigo_empresa, data)
END IF  
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "almartcajas_caja"
		bus_titulo     = "AYUDA SELECCION CAJAS"
		bus_datawindow = "dw_ayuda_cajas"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "almartcajas_caja"
		bus_titulo     = "AYUDA SELECCION CAJAS"
		bus_datawindow = "dw_ayuda_cajas"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_paletizado from u_datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 3515
integer y = 3104
integer width = 1591
integer height = 396
integer taborder = 260
boolean bringtotop = true
string dataobject = "dw_paletizado"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if

end event

event itemchanged;string v_Articulo

IF dwo.Name = "palarticulo_codigo" THEN
	dw_paletizado.object.pallets_descripcion[row] = f_nombre_pallet(codigo_empresa, data)

END IF  
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "palarticulo_codigo"
		bus_titulo     = "AYUDA SELECCION pallets"
		bus_datawindow = "dw_ayuda_pallets"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "palarticulo_codigo"
		bus_titulo     = "AYUDA SELECCION pallets"
		bus_datawindow = "dw_ayuda_pallets"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_calidad_altas from u_datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 1070
integer y = 3104
integer width = 1929
integer height = 396
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_calidad_altas"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if




end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type cb_duplicar from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 2752
integer y = 212
integer width = 654
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Duplicar"
end type

event clicked;
String articulo_origen, codigo_nuevo
transaction transaccion
str_colisiones param_colisiones
articulo_origen = sle_valor.text
Boolean res = true
str_parametros lstr_param

if isnull(sle_valor.text) or sle_valor.text = "" or dw_1.rowcount() <= 0 then
	return
end if

f_crear_transaccion(transaccion,"","",false,"TS","")
CONNECT USING transaccion;

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "articulos"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = false

codigo_nuevo = String(f_colisiones(transaccion, param_colisiones))

Datetime fecha_alta = Datetime(Today(),now())

INSERT INTO articulos (empresa, codigo, descripcion, descripcion_arabe, familia, marcas_codigo, submarcas_codigo, subfamilia, formato, ancho, largo, ancho_std, largo_std, subformato, modelo, unidad, precio_coste, fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, 
								decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, molde, 
								plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, referencia_laboratorio, version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, 
								espesor, ciclo, temp_inferior, temp_superior,  ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, ubi_muestras, 
								stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, marcado, etiqueta_ce, lote, observaciones, modelo_origen, pieza_origen, prueba_origen, 
								ean13_aux, bisel, relieve, cliente_marca, tipo_operacion, juegopantallas, cod_cliente2, costilla, formato_etiqueta, decimales_unidad,promocion) 
SELECT empresa, :codigo_nuevo, descripcion, descripcion_arabe, familia, marcas_codigo, submarcas_codigo, subfamilia, formato, ancho, largo, ancho_std, largo_std, subformato, modelo, unidad, precio_coste, :fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, 
								decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, molde, 
								plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, referencia_laboratorio, version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, 
								espesor, ciclo, temp_inferior, temp_superior,  ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, ubi_muestras, 
								stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, marcado, etiqueta_ce, lote, observaciones, modelo_origen, pieza_origen, prueba_origen, 
								ean13_aux, bisel, relieve, cliente_marca, tipo_operacion, juegopantallas, cod_cliente2, costilla, formato_etiqueta, decimales_unidad,promocion
FROM articulos 
WHERE empresa = :codigo_empresa AND codigo = :articulo_origen 
USING transaccion;
if transaccion.SQLCode <> 0 then
	res = false
end if

if res then
	INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha) 
	SELECT empresa, :codigo_nuevo, version, '0', factor, aprovecha
	FROM art_escandallo 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, aprovechar_base, tipo_version) 
	SELECT empresa, :codigo_nuevo, version, '0', descripcion, observaciones, aprovechar_base, tipo_version
	FROM art_versiones 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	INSERT INTO art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, orientacion, piezas_fila)
	SELECT empresa, :codigo_nuevo, version, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, orientacion, piezas_fila 
	FROM art_ver_operaciones 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	INSERT INTO art_ver_op_aplicaciones (empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, tipoaplicacion, orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, gram_7x20, tiff, perfil, archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba, orientacion, piezas_fila)
	SELECT empresa, :codigo_nuevo, version, operacion, contadoraplicacion, pantalla, formula, 0, tipoaplicacion, orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, 0, tiff, perfil, archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba, orientacion, piezas_fila
	FROM art_ver_op_aplicaciones 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	INSERT INTO art_codestadistico (empresa, codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID) 
	SELECT empresa, :codigo_nuevo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID 
	FROM art_codestadistico 
	WHERE empresa = :codigo_empresa AND codigo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	INSERT INTO almartcajas (empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales_caja, peso_real_caja, metros_reales, descripcion, codigo, pordefecto) 
	SELECT empresa, :codigo_nuevo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales_caja, peso_real_caja, metros_reales, descripcion, codigo, pordefecto 
	FROM almartcajas 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	INSERT INTO almartcal (empresa, articulo, calidad, precio, fecha_alta, stockmin, stockmax, puntopedido)
	SELECT empresa, :codigo_nuevo, calidad, precio, fecha_alta, stockmin, stockmax, puntopedido
	FROM almartcal 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	INSERT INTO palarticulo (empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
	SELECT empresa, :codigo_nuevo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto
	FROM palarticulo
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

//Solo imágenes procedentes de modelos y piezas
if res then
	INSERT INTO articulos_imagen_encajado (empresa, articulo, codigo, modelo, pieza, ruta, fichero, produccion, fecha_modificacion, tamanyo) 
	SELECT empresa, :codigo_nuevo, codigo, modelo, pieza, ruta, fichero, produccion, fecha_modificacion, tamanyo 
	FROM articulos_imagen_encajado 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_origen AND modelo IS NOT NULL 
	USING transaccion;
	if transaccion.SQLCode <> 0 then
		res = false
	end if
end if

if res then
	COMMIT USING transaccion;
else
	ROLLBACK USING transaccion;
	MessageBox("Error Duplicado", "Se ha producido un error realizando el duplicado.")
end if

DISCONNECT USING transaccion;
destroy transaccion;

if res then
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(codigo_nuevo, 0, tv_escandallo)
	sle_valor.Text = codigo_nuevo
	sle_valor.triggerEvent("tecla_tabulador")
end if


if messagebox("Aviso", " ¿Desea abrir el alta comercial? ", Question!, YesNO!, 1) = 1 then
	lstr_param.s_argumentos[1]  = "w_mant_altas_comercial"
	lstr_param.s_argumentos[2]  = codigo_nuevo 
	lstr_param.i_nargumentos    = 3
	OpenWithParm(w_mant_altas_comercial, lstr_param)	
end if

end event

type cb_3 from commandbutton within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 1431
integer y = 3104
integer width = 658
integer height = 112
integer taborder = 330
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Valoración de Stock"
end type

event clicked;f_valorar_stock()
end event

type cb_1 from commandbutton within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 2117
integer y = 3104
integer width = 658
integer height = 112
integer taborder = 340
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cálculos Caja"
end type

event clicked;Dec{3} peso_caja,peso_envase,peso_piezas,metros_caja,metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho
String cod_formato, var_caja

select piezascaja, caja
into :var_piezas, :var_caja
from almartcajas
where empresa = :codigo_empresa
and articulo = :sle_valor.text
and pordefecto = 'S'
using sqlca;


var_peso_pieza = f_peso_articulo (codigo_empresa,sle_valor.text)
peso_piezas = var_peso_pieza  * var_piezas
peso_envase     = f_peso_envase(codigo_empresa, var_caja)
peso_caja     = peso_envase + peso_piezas

cod_formato = f_formato_articulo (codigo_empresa,sle_valor.text)

var_largo = f_largo_formato(codigo_empresa,cod_formato)
var_ancho = f_ancho_formato(codigo_empresa,cod_formato)

metros_caja  = (var_piezas * var_largo*var_ancho)/10000
metrosl_caja = (var_piezas * var_largo)/100

update almartcajas 
set 	pesocaja = :peso_caja, 
		metroscaja= :metros_caja,
		metros_reales = :metros_caja,
		metroslcaja = :metrosl_caja		
where empresa = :codigo_empresa
and articulo = :sle_valor.text
and caja = :var_caja using SQLCA;

if SQLCA.SQLCode <> -1 then
	commit;
else
	rollback;
	messagebox("Error"," No se pueden insertar los cáculos de la caja. ")
end if


end event

type dw_listado_ficha from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 5751
integer y = 1560
integer width = 311
integer height = 180
integer taborder = 220
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_añadir_ver from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 2898
integer y = 1816
integer width = 2011
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;
long total_filas, fila_actual, nuevaversion, indice

dw_versiones.scrolltorow(dw_versiones.InsertRow(0))
dw_versiones.SetColumn(1)

fila_actual = dw_versiones.Getrow()
total_filas = dw_versiones.RowCount()

nuevaversion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_versiones.object.version[indice]) >= nuevaversion then
			nuevaversion = long(dw_versiones.object.version[indice]) + 1
		end if
	next
end if

dw_versiones.object.empresa[fila_actual] = codigo_empresa
dw_versiones.object.articulo[fila_actual] = sle_valor.text
dw_versiones.object.version[fila_actual] = string(nuevaversion)

if dw_versiones.rowcount() = 1 then
	dw_versiones.object.descripcion[fila_actual] = 'ÚNICA'
	dw_versiones.object.tipo_version[dw_versiones.getrow()] = 'P'
end if	
end event

type cb_eliminar_ver from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 4933
integer y = 1816
integer width = 1952
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;boolean error_borrando
long fila_actual, total_filas, indice
string operacion, tipoaplicacion, contadoraplicacion, ver

str_ventana_alerta parametros
string botones[2]
Int borrar_accion

parametros.titulo = "Atención"
parametros.subtitulo = "Borrar Versión"
parametros.mensaje = "Va a borrar definitivamente toda la versión del artículo, incluyendo operaciones y aplicaciones, ¿Desea continuar, "+nombre_usuario+"?"
parametros.tipo = 1
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar_accion = Int(Message.DoubleParm)
if borrar_accion <> 1 then
	return
end if

ver = dw_versiones.object.version[dw_versiones.getrow()]

error_borrando = False

//Borramos las Aplicaciones


if not error_borrando then
    delete from art_ver_op_aplicaciones
    where empresa  = :codigo_empresa
    and    articulo = :sle_valor.text
    and    version  = :ver 
	 using sqlca;
   
    if SQLCA.SQLCode = -1 then
        error_borrando = True
    end if
end if


//Borrar escandallo
if not error_borrando then
    delete from art_escandallo
    where empresa  = :codigo_empresa
    and    articulo = :sle_valor.text
    and    version  = :ver
	 using sqlca;

   
    if SQLCA.SQLCode = -1 then
        error_borrando = True
    end if
end if


// Borramos las operaciones

if not error_borrando then
    delete from art_ver_operaciones
    where empresa  = :codigo_empresa
    and    articulo = :sle_valor.text
    and    version  = :ver
	 using sqlca;

   
    if SQLCA.SQLCode = -1 then
        error_borrando = True
    end if
end if

// Borramos la version

if not error_borrando then
    fila_actual = dw_versiones.DeleteRow(0)
    if dw_versiones.Update() = -1 then
        error_borrando = True
    end if
end if



if error_borrando then
    rollback using sqlca;
else
	commit using sqlca;
	dw_operaciones.reset()
	dw_aplicaciones.reset()

end if

dw_versiones.retrieve(codigo_empresa,sle_valor.text)

end event

type st_2 from statictext within w_mant_altas_intermedios_nuevo
integer x = 2715
integer y = 2604
integer width = 4233
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Operaciones"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_añadir from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 2743
integer y = 2936
integer width = 1399
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;
long total_filas, fila_actual, nuevaoperacion, orden, indice
string ver

total_filas = dw_operaciones.RowCount()
if total_filas >= 1 then
	messagebox("Error", 'No se puede insertar más de una operación')
	return
end if

ver = dw_versiones.object.version[dw_versiones.getrow()]

if not isnull(ver) and ver <> '' then
	DW_operaciones.scrolltorow(DW_operaciones.InsertRow(0))
	DW_operaciones.SetColumn(1)
	
	fila_actual = dw_operaciones.Getrow()
	
	orden = 1
	if total_filas > 0 then
		orden = total_filas
	end if
	
	nuevaoperacion = 1 
	if total_filas > 0 then
		for indice = 1 to total_filas 
			if long(dw_operaciones.object.operacion[indice]) >= nuevaoperacion then
				nuevaoperacion = long(dw_operaciones.object.operacion[indice]) + 1
			end if
		next
	end if
	
	dw_operaciones.object.empresa[fila_actual] = codigo_empresa
	dw_operaciones.object.articulo[fila_actual] = sle_valor.text
	dw_operaciones.object.version[fila_actual] = ver
	dw_operaciones.object.operacion[fila_actual] = string(nuevaoperacion)
	dw_operaciones.object.orden[fila_actual] = string(orden)
	dw_operaciones.object.art_ver_operaciones_formato[fila_actual] = dw_1.object.articulos_formato[dw_1.getrow()]
	dw_operaciones.object.art_ver_operaciones_factor[fila_actual] = 1
	dw_operaciones.object.formatos_descripcion[fila_actual] = dw_1.object.formatos_abreviado[dw_1.getrow()]

else
	messagebox("Error", 'Número de versión no valido')
end if
end event

type cb_eliminar from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 4165
integer y = 2936
integer width = 1390
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;
boolean error_borrando
long fila_actual, total_filas, indice, i, total_aplicaciones
string operacion, tipoaplicacion, contadoraplicacion, ver

error_borrando = False

if dw_operaciones.Rowcount() > 0 then
	fila_actual = dw_operaciones.getrow()
	ver = dw_versiones.object.version[dw_versiones.getrow()]
	operacion = dw_operaciones.object.operacion[fila_Actual]
end if


// Borramos la operacion
total_aplicaciones =  dw_aplicaciones.rowcount()

for i = 1 to total_aplicaciones
	dw_aplicaciones.deleterow(0)
next 

if dw_aplicaciones.Update() = -1 then
	error_borrando = True
end if

if not error_borrando then
	fila_actual = dw_operaciones.DeleteRow(0)
	total_filas = dw_operaciones.Rowcount()
	
	for indice = fila_actual to total_filas
		dw_operaciones.object.orden[indice] = string(indice)
	next	
	if dw_operaciones.Update() = -1 then
		error_borrando = True
	end if
end if




if error_borrando then
	rollback using SQLCA;
else
	commit using SQLCA;
end if
dw_operaciones.retrieve(codigo_empresa, sle_valor.text, ver)


end event

type cb_intercalar from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 5586
integer y = 2936
integer width = 1326
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Intercalar"
end type

event clicked;
long total_filas, fila_actual, indice, orden, nuevaoperacion
string ver

ver = dw_versiones.object.version[dw_versiones.getrow()]

if not isnull(ver) and ver <> '' then

	fila_actual = dw_operaciones.Getrow()
	total_filas = dw_operaciones.RowCount()
	
	DW_operaciones.scrolltorow(DW_operaciones.InsertRow(fila_actual))
	DW_operaciones.SetColumn(1)
	
	total_filas = dw_operaciones.RowCount()
	
	orden = fila_actual
	for indice = fila_actual+1 to total_filas
		 dw_operaciones.object.orden[indice] = string(indice)
	next
	
	nuevaoperacion = 1 
	if total_filas > 0 then
		for indice = 1 to total_filas 
			if long(dw_operaciones.object.operacion[indice]) >= nuevaoperacion then
				nuevaoperacion = long(dw_operaciones.object.operacion[indice]) + 1
			end if
		next
	end if
	
	dw_operaciones.object.empresa[fila_actual] = codigo_empresa
	dw_operaciones.object.articulo[fila_actual] = sle_valor.text
	dw_operaciones.object.version[fila_actual] = ver
	dw_operaciones.object.operacion[fila_actual] = string(nuevaoperacion)
	dw_operaciones.object.orden[fila_actual] = string(orden)
	dw_operaciones.object.art_ver_operaciones_factor[fila_actual] = 1
else
	messagebox("Error", 'Número de versión no valido')
end if



end event

type st_3 from statictext within w_mant_altas_intermedios_nuevo
integer x = 2757
integer y = 1400
integer width = 4219
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8421376
string text = "Versiones"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_aplicaciones from u_datawindow within w_mant_altas_intermedios_nuevo
integer x = 18
integer y = 3188
integer width = 6926
integer height = 608
integer taborder = 180
boolean bringtotop = true
string dataobject = "dw_art_ver_op_aplicaciones_nuevo"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;str_parametros lstr_param
String tipoaplicacion, formula_estandar, formula
Dec gramaje, metros2_pieza
Int fila_v, fila_e, fila_op, fila_ap

dw_1.enabled = false
dw_operaciones.enabled = false
if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
	parent.TriggerEvent("ue_desactiva_claves")
	cb_insertar.enabled   = TRUE
end if
dw_1.enabled = True
dw_operaciones.enabled = True

If row=0 Then Return
IF ue_marca_linea = TRUE Then
//  This.SelectRow(0,FALSE)
//  This.SelectRow(row,TRUE)
  SetRow(row)
END IF

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_aplicacion"
			lstr_param.s_argumentos[1]  = "wi_mant_prodaplicaciones"
			lstr_param.s_argumentos[2]  = this.object.tipoaplicacion[this.getrow()]
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_prodaplicaciones, lstr_param)
		CASE "pb_formula"
			//Atención a las formulas estandar y su introducción de datos para costes
			tipoaplicacion = this.object.tipoaplicacion[row]
			formula = this.object.formula[this.getrow()]
			metros2_pieza = dw_operaciones.object.formatos_ancho[dw_operaciones.getrow()] * dw_operaciones.object.formatos_largo[dw_operaciones.getrow()] / 10000
			
			SELECT formula_estandar INTO :formula_estandar FROM prodaplicaciones WHERE empresa = :codigo_empresa AND codigo = :tipoaplicacion;
			
			lstr_param.s_argumentos[1]  = "wi_mant_formulaciones"
			lstr_param.s_argumentos[2]  = this.object.formula[this.getrow()]
			lstr_param.s_argumentos[3]  = formula_estandar
			lstr_param.s_argumentos[4]  = String(metros2_pieza)
			lstr_param.i_nargumentos    = 4
			OpenWithParm(wi_mant_formulaciones, lstr_param)
			if formula_estandar = '1' and formula <> "" then
				gramaje = Dec(Message.DoubleParm)
				/*
				if not isnull(this.object.gramaje[this.getrow()]) and this.object.gramaje[this.getrow()] <> 0 and gramaje <> this.object.gramaje[this.getrow()] then
					if MessageBox("Atención", "¿Desea reemplazar el gramaje ya existente por el calculado en la fórmula?", Question!, YesNo!, 2) = 2 then
						return
					end if
				end if
				*/
				this.object.gramaje[this.getrow()] = gramaje
				fila_v = dw_versiones.getrow()
				fila_e = dw_escandallo.getrow()
				fila_op = dw_operaciones.getrow()
				fila_ap = dw_aplicaciones.getrow()
				cb_insertar.triggerevent(clicked!)
				
				dw_versiones.SetRow (fila_v)
				dw_versiones.SelectRow(0, false)
				dw_versiones.SelectRow(fila_v, true)

				dw_escandallo.SetRow (fila_e)
				dw_escandallo.SelectRow(0, false)
				dw_escandallo.SelectRow(fila_e, true)
				
				dw_operaciones.SetRow (fila_op)
				dw_operaciones.SelectRow(0, false)
				dw_operaciones.SelectRow(fila_op, true)
				
				this.SetRow (fila_ap)
				this.SelectRow(0, false)
				this.SelectRow(fila_ap, true)
				
			end if
		CASE "pb_pantalla"
			lstr_param.s_argumentos[1]  = "wi_mant_prodpantallas"
			lstr_param.s_argumentos[2]  = this.object.pantalla[this.getrow()]	
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_prodpantallas, lstr_param)
	END CHOOSE
end if


end event

event itemchanged;string v_descripcion, tipoaplicacion, desc_formula, formula_estandar, formula_unidad, formula, formula_nueva, tiff, desc_unidad, sel2, mprima, proveedor, unidad_mprima
dec v_hilos
dec gramaje, ancho, largo, gram_7x20, gram_cm2, v_paso_cliche
str_colisiones param_colisiones
transaction trm
datastore mprimas
datetime ahora
int rtn, j, numero2, posicion_sufijo
//long paso_cliche

String prefijo, tipomaq, codigo, sufijo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda
int orden_formula

CHOOSE CASE dwo.Name 
	CASE "tipoaplicacion"
		dw_aplicaciones.object.prodaplicaciones_resumido[row] = f_nombre_aplicacion_Abr (codigo_empresa,data)
	CASE "art_ver_op_aplicaciones_archivo_disenyo_codigo"
		prefijo = Left (data,1)
		posicion_sufijo  = pos(data,"-")
		SELECT codigo INTO :tipomaq FROM tipomaquina_disenyo WHERE empresa = :codigo_empresa AND prefijo = :prefijo;
		codigo = Mid(data, 2)
		busqueda.consulta  = " SELECT CONVERT(char(15), archivo_disenyo_sistema_archivos.fichero), archivo_disenyo_sistema_archivos.observaciones, archivo_disenyo_sistema_archivos.codigo "+&
									" FROM archivo_disenyo_sistema_archivos "+&
									" WHERE empresa = '"+codigo_empresa+"' AND tipomaquina_disenyo = '"+tipomaq+"' AND archivo = '"+codigo+"' "+&
									" ORDER BY archivo_disenyo_sistema_archivos.codigo "
		if posicion_sufijo > 0 then
			sufijo = Mid(data, posicion_sufijo + 1)
			codigo = Mid(data, 2, posicion_sufijo - 2)
			busqueda.consulta  = " SELECT CONVERT(char(15), archivo_disenyo_sistema_archivos.fichero), archivo_disenyo_sistema_archivos.observaciones, archivo_disenyo_sistema_archivos.codigo "+&
									" FROM archivo_disenyo_sistema_archivos "+&
									" WHERE empresa = '"+codigo_empresa+"' AND tipomaquina_disenyo = '"+tipomaq+"' AND archivo = '"+codigo+"' and codigo = '"+sufijo+"'"+&
									" ORDER BY archivo_disenyo_sistema_archivos.codigo "
		end if
		busqueda.titulos[1] = "Fichero"
		busqueda.titulos[2] = "Observaciones"
		busqueda.titulos[3] = "Archivo Diseño Prueba"
		
		OpenWithParm(wt_busquedas, busqueda)
		resultado = Message.PowerObjectParm
		if resultado.resultado > 0 then
			this.object.art_ver_op_aplicaciones_archivo_disenyo_tipomaquina_disenyo[this.GetRow()] = tipomaq	
			dwo.Primary[row] = codigo
			//this.object.art_ver_op_aplicaciones_archivo_disenyo_codigo[this.GetRow()] 					= codigo
			this.object.art_ver_op_aplicaciones_archivo_disenyo_prueba[this.GetRow()]					= resultado.valores[3]	
			this.object.archivo_disenyo_sistema_archivos_fichero[this.GetRow()] 		  					= resultado.valores[1]		
			
			this.EVENT itemchanged(row,this.object.formula,data)
			return 2
		else
			dwo.Primary[row] = ''
			this.object.art_ver_op_aplicaciones_archivo_disenyo_tipomaquina_disenyo[this.GetRow()] = ""	
			this.object.art_ver_op_aplicaciones_archivo_disenyo_prueba[this.GetRow()]					= ""	
			this.object.archivo_disenyo_sistema_archivos_fichero[this.GetRow()] 		  					= ""		
			return 2	
		end if	
		//dw_aplicaciones.Accepttext()
		
	CASE "formula"
		
		dw_aplicaciones.Accepttext()
		desc_formula = f_nombre_formulacion_produccion (codigo_empresa,data)
		tipoaplicacion = this.object.tipoaplicacion[row]
		
		if (isnull(desc_formula) or desc_formula = "") and not isnull(tipoaplicacion) and tipoaplicacion <> "" and not isnull(data) and data <> "" then
			desc_formula = ""
			SELECT formula, descripcion_laboratorio INTO :formula, :desc_formula FROM prodformula WHERE empresa = :codigo_empresa AND descripcion_laboratorio = :data;
			if not isnull(formula) and formula <> "" then 
				dwo.Primary[row] = formula
				f_nombre_formulacion_produccion (codigo_empresa,formula)
			end if
			SELECT formula_estandar, formula_unidad INTO :formula_estandar, :formula_unidad FROM prodaplicaciones WHERE empresa = :codigo_empresa AND codigo = :tipoaplicacion;
			if formula_estandar = '1' and desc_formula = "" then
				if MessageBox("Creación Formula Estándard","¿Desea generar una formula estándar con la descripcción "+data+"?",Question!,YesNo!,2) = 1 then
					
					//CREAR NUEVA FORMULA (Si existiera ya la hubiera encontrado f_nombre_formulacion_produccion)
					
					f_crear_transaccion(trm,"","",false,"TS","")
					CONNECT USING trm;
					param_colisiones.empresa = codigo_empresa
					param_colisiones.tabla = "prodformula"
					param_colisiones.campo = "formula"
					param_colisiones.filtro = ""
					param_colisiones.buscar_huecos = false
					formula_nueva = String(f_colisiones(trm, param_colisiones))
					ahora = datetime(today(),now())
					rtn = 1
					
					SELECT abreviado INTO :desc_unidad FROM comunimedida WHERE codigo = :formula_unidad USING trm;
					desc_unidad = lower(desc_unidad)
					tiff = data
					INSERT INTO prodformula (empresa, formula, descripcion_produccion, descripcion_laboratorio, fecha_alta, empleado, paletacolor, colorimetro, coste_kg_formula, 
													textura, activa_en_produccion, mp_equivalente, referencia_general, unidad_coste) 
					VALUES (:codigo_empresa, :formula_nueva, :tiff, :tiff, :ahora, NULL, NULL, NULL, NULL, NULL, 'S', NULL, NULL, :formula_unidad) USING trm;
					IF trm.SQLCode <> 0 THEN         
						MessageBox("SQL error Fórmula", trm.SQLErrText)
						rtn = -1
					END IF
					
					
					//Componentes de la formula (extraidos de la estándar)
					sel2 = "SELECT mprima, proveedor, unidad, orden FROM prodaplicacion_mprima WHERE empresa = '"+codigo_empresa+"' AND aplicacion = '"+tipoaplicacion+"'"
					f_cargar_cursor_trans (trm,  sel2,  mprimas)
					numero2 = mprimas.RowCount()
					j = 1
					do while (j <= numero2 AND rtn = 1) 
						mprima = mprimas.object.mprima[j]
						proveedor = mprimas.object.proveedor[j]
						unidad_mprima = mprimas.object.unidad[j]
						orden_formula = mprimas.object.orden[j]
						
						INSERT INTO proddetformula (empresa, formulacion, mp, cantidad, unidadmedida, proveedor, cantidad_u_m_mp, unidad_u_m_mp, coste_mp, orden) 
						VALUES (:codigo_empresa, :formula_nueva, :mprima, NULL, :desc_unidad, :proveedor, 0, :unidad_mprima ,0, :orden_formula) USING trm;
						IF trm.SQLCode <> 0 THEN         
							MessageBox("SQL error Componentes Fórmula ", trm.SQLErrText)
							rtn = -1
						END IF
						j++
					loop
					mprimas.reset()
					
					if rtn = 1 then
						COMMIT USING trm;
						DISCONNECT USING trm;
						dwo.Primary[row] = formula_nueva
						dw_aplicaciones.object.prodformula_descripcion_produccion[row] = tiff
						return 2
					else
						ROLLBACK USING trm;
						DISCONNECT USING trm;
						dw_aplicaciones.object.prodformula_descripcion_produccion[row] = ""
					end if
				else
					dwo.Primary[row] = ''
					this.object.prodformula_descripcion_produccion[row] = ""
					destroy trm
					destroy mprimas
					return 2	
				end if
			end if
		end if
		dw_aplicaciones.object.prodformula_descripcion_produccion[row] = desc_formula
		dw_aplicaciones.Accepttext()
	CASE "cod_pantalla"
		dw_aplicaciones.Accepttext()
		ancho = dw_operaciones.object.formatos_ancho[dw_operaciones.getrow()]
		largo = dw_operaciones.object.formatos_largo[dw_operaciones.getrow()]

		f_calculo_peso_mp ( data, ancho, largo, v_hilos, v_paso_cliche, gramaje, v_descripcion )

		dw_aplicaciones.object.gramaje[row] = gramaje
		dw_aplicaciones.object.prodpantallas_descripcion[row] = v_descripcion 
		dw_aplicaciones.object.prodpantallas_numero_hilos[row] = v_hilos  
		dw_aplicaciones.object.prodpantallas_paso_cliche[row] = v_paso_cliche
		dw_aplicaciones.Accepttext()
		

	CASE "art_ver_op_aplicaciones_gram_7x20"  // Cálculo del gramaje de la pieza a partir del gramaje en una pieza de 7x20
		dw_aplicaciones.Accepttext()
		if not isnull (dw_aplicaciones.object.art_ver_op_aplicaciones_gram_7x20) then
			gram_7x20 = dw_aplicaciones.object.art_ver_op_aplicaciones_gram_7x20[row]
			ancho = dw_operaciones.object.formatos_ancho[dw_operaciones.getrow()]
			largo = dw_operaciones.object.formatos_largo[dw_operaciones.getrow()]
			
			
			gramaje = ancho * largo * ( gram_7x20 / (7 * 20) )
			dw_aplicaciones.object.gramaje[row] = gramaje
			
		end if
	
	CASE "art_ver_op_aplicaciones_perfil"
		SELECT descripcion 
		INTO :v_descripcion
		FROM perfil_color 
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			dw_aplicaciones.object.perfil_color_descripcion[Row] 		= v_descripcion
		else
			dwo.Primary[row] = ''
			dw_aplicaciones.object.perfil_color_descripcion[Row] 		= ''
			destroy trm
			destroy mprimas
			return 2			
		end if
END CHOOSE

destroy trm
destroy mprimas

end event

event rbuttondown;str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

string juegopantallas

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "cod_pantalla"
		if dw_operaciones.rowcount() > 0 then
			juegopantallas = dw_operaciones.object.art_ver_operaciones_juegopantallas[dw_operaciones.getrow()]
			bus_titulo     = "AYUDA SELECCION PANTALLAS"
			bus_datawindow = "dw_ayuda_prodpantallas"
			bus_filtro     = " juegopantallas = '"+juegopantallas+"'"
		end if	
	CASE "art_ver_op_aplicaciones_archivo_disenyo_codigo"
		busqueda.consulta  = " SELECT archivo_disenyo_sistema_archivos.tipomaquina_disenyo, CONVERT(char(20),tipomaquina_disenyo.descripcion), "+&
										" CONVERT(char(15),archivo_disenyo_sistema_archivos.fichero), archivo_disenyo_sistema_archivos.observaciones, "+&
										" archivo_disenyo.codigo, archivo_disenyo_sistema_archivos.codigo "+&
										" FROM archivo_disenyo "+&
										" INNER JOIN tipomaquina_disenyo ON archivo_disenyo.empresa = tipomaquina_disenyo.empresa AND archivo_disenyo.tipomaquina_disenyo = tipomaquina_disenyo.codigo "+&
										" INNER JOIN archivo_disenyo_sistema_archivos ON archivo_disenyo.empresa = archivo_disenyo_sistema_archivos.empresa AND archivo_disenyo.tipomaquina_disenyo = archivo_disenyo_sistema_archivos.tipomaquina_disenyo AND archivo_disenyo.codigo = archivo_disenyo_sistema_archivos.archivo "+&
										" WHERE archivo_disenyo.empresa = '"+codigo_empresa+"' "+&
										" ORDER BY archivo_disenyo.tipomaquina_disenyo, archivo_disenyo.nombre"
										
			busqueda.titulos[1] = "Código Tipo Máquina"
			busqueda.titulos[2] = "Tipo Máquina"
			busqueda.titulos[3] = "Fichero"
			busqueda.titulos[4] = "Observaciones"
			busqueda.titulos[5] = "Archivo Diseño"
			busqueda.titulos[6] = "Archivo Diseño Prueba"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.art_ver_op_aplicaciones_archivo_disenyo_tipomaquina_disenyo[this.GetRow()] = resultado.valores[1]	
				this.object.art_ver_op_aplicaciones_archivo_disenyo_codigo[this.GetRow()] 					= resultado.valores[5]
				this.object.art_ver_op_aplicaciones_archivo_disenyo_prueba[this.GetRow()]					= resultado.valores[6]	
				this.object.archivo_disenyo_sistema_archivos_fichero[this.GetRow()] 		  					= resultado.valores[3]					
			end if	
			return
			
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULAS"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 	
	CASE "tipoaplicacion"
		bus_titulo     = "AYUDA SELECCION APLICACIONES"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown

end event

event retrieveend;if this.rowcount() >0 then
   This.event rowfocuschanged(1)
end if

end event

event key;string juegopantallas, modelo_origen, pieza_origen, prueba_origen
bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

CHOOSE CASE bus_campo
	CASE "cod_pantalla"
		if dw_operaciones.rowcount() > 0 then
			juegopantallas = dw_operaciones.object.art_ver_operaciones_juegopantallas[dw_operaciones.getrow()]
			bus_titulo     = "AYUDA SELECCION PANTALLAS"
			bus_datawindow = "dw_ayuda_prodpantallas"
			bus_filtro     = " juegopantallas = '"+juegopantallas+"'"
		end if	
	CASE "art_ver_op_aplicaciones_archivo_disenyo_codigo"
			//ESTO PERMITE USAR FORMULAS ESTANDAR (Problemas de las ventanas antiguas, que no dejan funcionar bien el evento itemchanged)
			IF KeyDown(KeyEnter!) then
				modelo_origen = dw_1.object.articulos_modelo_origen[dw_1.getrow()]
				pieza_origen = dw_1.object.articulos_pieza_origen[dw_1.getrow()]
				prueba_origen = dw_1.object.articulos_prueba_origen[dw_1.getrow()]
				if not isnull(modelo_origen) and modelo_origen <> "" then
					
					if not isnull(pieza_origen) and pieza_origen <> "" then
						busqueda.consulta  = " SELECT archivo_disenyo_sistema_archivos.tipomaquina_disenyo, CONVERT(char(15),archivo_disenyo_sistema_archivos.fichero), CONVERT(char(20),tipomaquina_disenyo.descripcion), "+&
												" archivo_disenyo_sistema_archivos.observaciones, "+&
												" archivo_disenyo.codigo, archivo_disenyo_sistema_archivos.codigo, tipomaquina_disenyo.prefijo "+&
												" FROM archivo_disenyo "+&
												" INNER JOIN tipomaquina_disenyo ON archivo_disenyo.empresa = tipomaquina_disenyo.empresa AND archivo_disenyo.tipomaquina_disenyo = tipomaquina_disenyo.codigo "+&
												" INNER JOIN archivo_disenyo_sistema_archivos ON archivo_disenyo.empresa = archivo_disenyo_sistema_archivos.empresa AND archivo_disenyo.tipomaquina_disenyo = archivo_disenyo_sistema_archivos.tipomaquina_disenyo AND archivo_disenyo.codigo = archivo_disenyo_sistema_archivos.archivo "+&
												" INNER JOIN modelo_archivo ON modelo_archivo.empresa  = archivo_disenyo.empresa AND modelo_archivo.tipo_maquina_disenyo  = archivo_disenyo.tipomaquina_disenyo AND modelo_archivo.archivo_disenyo = archivo_disenyo.codigo "+&
												" WHERE archivo_disenyo.empresa = '"+codigo_empresa+"' "+&
												" AND modelo_archivo.modelo = '"+modelo_origen+"' "+&
												" AND modelo_archivo.cliente = (SELECT cliente FROM modelo_pieza WHERE empresa = modelo_archivo.empresa AND codigo_lab = '"+pieza_origen+"') "+&
												" AND modelo_archivo.propuesta = (SELECT propuesta FROM modelo_pieza WHERE empresa = modelo_archivo.empresa AND codigo_lab = '"+pieza_origen+"') "+&
												" AND modelo_archivo.pieza = (SELECT codigo FROM modelo_pieza WHERE empresa = modelo_archivo.empresa AND codigo_lab = '"+pieza_origen+"') "+&
												" ORDER BY archivo_disenyo.tipomaquina_disenyo, archivo_disenyo.nombre"
					else
						busqueda.consulta  = " SELECT archivo_disenyo_sistema_archivos.tipomaquina_disenyo, CONVERT(char(15),archivo_disenyo_sistema_archivos.fichero), CONVERT(char(20),tipomaquina_disenyo.descripcion), "+&
												" archivo_disenyo_sistema_archivos.observaciones, "+&
												" archivo_disenyo.codigo, archivo_disenyo_sistema_archivos.codigo, tipomaquina_disenyo.prefijo "+&
												" FROM archivo_disenyo "+&
												" INNER JOIN tipomaquina_disenyo ON archivo_disenyo.empresa = tipomaquina_disenyo.empresa AND archivo_disenyo.tipomaquina_disenyo = tipomaquina_disenyo.codigo "+&
												" INNER JOIN archivo_disenyo_sistema_archivos ON archivo_disenyo.empresa = archivo_disenyo_sistema_archivos.empresa AND archivo_disenyo.tipomaquina_disenyo = archivo_disenyo_sistema_archivos.tipomaquina_disenyo AND archivo_disenyo.codigo = archivo_disenyo_sistema_archivos.archivo "+&
												" INNER JOIN modelo_archivo ON modelo_archivo.empresa  = archivo_disenyo.empresa AND modelo_archivo.tipo_maquina_disenyo  = archivo_disenyo.tipomaquina_disenyo AND modelo_archivo.archivo_disenyo = archivo_disenyo.codigo "+&
												" WHERE archivo_disenyo.empresa = '"+codigo_empresa+"' "+&
												" AND modelo_archivo.modelo = '"+modelo_origen+"' "+&
												" ORDER BY archivo_disenyo.tipomaquina_disenyo, archivo_disenyo.nombre"
					end if

				else
					busqueda.consulta  = " SELECT archivo_disenyo_sistema_archivos.tipomaquina_disenyo, CONVERT(char(15),archivo_disenyo_sistema_archivos.fichero), CONVERT(char(20),tipomaquina_disenyo.descripcion), "+&
												" archivo_disenyo_sistema_archivos.observaciones, "+&
												" archivo_disenyo.codigo, archivo_disenyo_sistema_archivos.codigo, tipomaquina_disenyo.prefijo "+&
												" FROM archivo_disenyo "+&
												" INNER JOIN tipomaquina_disenyo ON archivo_disenyo.empresa = tipomaquina_disenyo.empresa AND archivo_disenyo.tipomaquina_disenyo = tipomaquina_disenyo.codigo "+&
												" INNER JOIN archivo_disenyo_sistema_archivos ON archivo_disenyo.empresa = archivo_disenyo_sistema_archivos.empresa AND archivo_disenyo.tipomaquina_disenyo = archivo_disenyo_sistema_archivos.tipomaquina_disenyo AND archivo_disenyo.codigo = archivo_disenyo_sistema_archivos.archivo "+&
												" WHERE archivo_disenyo.empresa = '"+codigo_empresa+"' "+&
												" ORDER BY archivo_disenyo.tipomaquina_disenyo, archivo_disenyo.nombre"
				end if
								
				busqueda.titulos[1] = "Código Tipo Máquina"
				busqueda.titulos[3] = "Tipo Máquina"
				busqueda.titulos[2] = "Fichero"
				busqueda.titulos[4] = "Observaciones"
				busqueda.titulos[5] = "Archivo Diseño"
				busqueda.titulos[6] = "Archivo Diseño Prueba"
				busqueda.titulos[7] = "Tipo Máquina Prefijo"
				
				OpenWithParm(wt_busquedas, busqueda)
				resultado = Message.PowerObjectParm
				if resultado.resultado > 0 then
					this.object.art_ver_op_aplicaciones_archivo_disenyo_tipomaquina_disenyo[this.GetRow()] = resultado.valores[1]
					this.object.art_ver_op_aplicaciones_archivo_disenyo_codigo[this.GetRow()] 					= resultado.valores[5]
					this.object.art_ver_op_aplicaciones_archivo_disenyo_prueba[this.GetRow()]					= resultado.valores[6]	
					this.object.archivo_disenyo_sistema_archivos_fichero[this.GetRow()] 		  					= resultado.valores[2]
					this.EVENT itemchanged(this.GetRow(),this.object.formula, (resultado.valores[7]+resultado.valores[5]))
				end if	
				return
			else
				return
			end if
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULAS"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 	
		//ESTO PERMITE USAR FORMULAS ESTANDAR (Problemas de las ventanas antiguas, que no dejan funcionar bien el evento itemchanged)
		IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) OR KeyDown(KeyF12!) then
			
		else
			return
		end if
	CASE "tipoaplicacion"
		bus_titulo     = "AYUDA SELECCION APLICACIONES"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_filtro     = "" 	
		
	CASE "art_ver_op_aplicaciones_perfil"	
		if key =  keyEnter! then
			busqueda.titulo_ventana = "Búsqueda de Perfiles de Color"
			busqueda.consulta =  " SELECT perfil_color.codigo, perfil_color.descripcion "+&	
										" FROM perfil_color "+&
										" WHERE perfil_color.empresa = '"+codigo_empresa+"' "+&
										" ORDER BY CONVERT(INTEGER, perfil_color.codigo) asc"
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_aplicaciones.object.art_ver_op_aplicaciones_perfil[dw_aplicaciones.GetRow()] 	= resultado.valores[1]		// Devuelve el valor que encuentra ...
				dw_aplicaciones.object.perfil_color_descripcion[dw_aplicaciones.GetRow()] 			= resultado.valores[2]	
			end if	
			return
		end if
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key


end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type cb_añadir2 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 32
integer y = 3804
integer width = 2391
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;
long total_filas, fila_actual, nuevaaplicacion, orden, indice
string operacion , ver

ver = dw_versiones.object.version[dw_versiones.getrow()]

operacion = dw_operaciones.object.operacion[dw_operaciones.getrow()]
dw_aplicaciones.scrolltorow(dw_aplicaciones.InsertRow(0))
dw_aplicaciones.SetColumn(1)

fila_actual = dw_aplicaciones.Getrow()
total_filas = dw_aplicaciones.RowCount()

orden = 1
if total_filas > 0 then
	orden = total_filas
end if

nuevaaplicacion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_aplicaciones.object.contadoraplicacion[indice]) >= nuevaaplicacion then
			nuevaaplicacion = long(dw_aplicaciones.object.contadoraplicacion[indice]) + 1
		end if
	next
end if

dw_aplicaciones.object.empresa[fila_actual] = codigo_empresa
dw_aplicaciones.object.articulo[fila_actual] = sle_valor.text
dw_aplicaciones.object.operacion[fila_actual] =operacion
dw_aplicaciones.object.version[fila_actual] = ver
dw_aplicaciones.object.contadoraplicacion[fila_actual] = string(nuevaaplicacion)
dw_aplicaciones.object.orden[fila_actual] = string(orden)



end event

type cb_eliminar2 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 2427
integer y = 3804
integer width = 2226
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;
boolean error_borrando
long fila_actual, total_filas, indice
string operacion, tipoaplicacion, contadoraplicacion, ver

dw_versiones.object.version[dw_versiones.getrow()]

error_borrando = False

if dw_operaciones.Rowcount() > 0 then
	fila_actual = dw_operaciones.getrow()
	operacion = dw_operaciones.object.operacion[fila_Actual]
end if

fila_actual = dw_aplicaciones.getrow()
if dw_aplicaciones.Rowcount() > 0 then
	tipoaplicacion = dw_aplicaciones.object.tipoaplicacion[fila_Actual]
	contadoraplicacion = dw_aplicaciones.object.contadoraplicacion[fila_Actual]
end if


// Borramos la aplicacion
if not error_borrando then
	fila_actual = dw_aplicaciones.DeleteRow(0)
	total_filas = dw_aplicaciones.Rowcount()
	
	for indice = fila_actual to total_filas
		dw_aplicaciones.object.orden[indice] = string(indice)
	next	
	if dw_aplicaciones.Update() = -1 then
		error_borrando = True
	end if
end if

if error_borrando then
	rollback using sqlca;
else
	commit using sqlca;
end if

fila_actual = dw_operaciones.getrow()
operacion = dw_operaciones.object.operacion[fila_Actual]
//dw_aplicaciones.retrieve (codigo_empresa,sle_valor.text, ver, operacion)

total_filas = dw_aplicaciones.RowCount()

for indice = 1 to total_filas
	dw_aplicaciones.object.orden[indice] = string(indice)
next




end event

type cb_intercalar2 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 4658
integer y = 3804
integer width = 2277
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Intercalar"
end type

event clicked;
long total_filas, fila_actual, indice, orden, nuevaaplicacion
string operacion, ver

ver = dw_versiones.object.version[dw_versiones.getrow()]

if dw_operaciones.RowCount() > 0 then
	operacion	= dw_operaciones.object.operacion[dw_operaciones.getrow()]
else
	return 0
end if

if dw_aplicaciones.RowCount() > 0 then
	fila_actual = dw_aplicaciones.Getrow()
	total_filas = dw_aplicaciones.RowCount()
end if
 
orden = fila_actual
// Incrementamos el orden de los registro en uno 
for indice = fila_actual to total_filas
 	 dw_aplicaciones.object.orden[indice] = string(indice+1)
next

nuevaaplicacion = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_aplicaciones.object.contadoraplicacion[indice]) >= nuevaaplicacion then
			nuevaaplicacion = long(dw_aplicaciones.object.contadoraplicacion[indice]) + 1
		end if
	next
end if

dw_aplicaciones.scrolltorow(dw_aplicaciones.InsertRow(fila_actual))  
dw_aplicaciones.SetColumn(1)														


dw_aplicaciones.object.empresa[fila_actual] = codigo_empresa
dw_aplicaciones.object.articulo[fila_actual] = sle_valor.text
dw_aplicaciones.object.version[fila_actual] = ver
dw_aplicaciones.object.operacion[fila_actual] = operacion
dw_aplicaciones.object.contadoraplicacion[fila_actual] = string(nuevaaplicacion)
dw_aplicaciones.object.orden[fila_actual] = string(orden)



//messagebox ("", "ARTIUCLO: "+SLE_VALOR.TEXT+"  VERSION: "+STRING (VER)+" OPERACION: "+STRING(OPERACION)+" CONTADOR: "+string(nuevaaplicacion))
end event

type dw_escandallo from u_datawindow within w_mant_altas_intermedios_nuevo
integer x = 2757
integer y = 2004
integer width = 1582
integer height = 468
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_escandallo"
boolean vscrollbar = true
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
	parent.TriggerEvent("ue_desactiva_claves")
	cb_insertar.enabled   = TRUE
end if

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_tipooperacion"
			lstr_param.s_argumentos[1]  = "w_mant_art_ver_tipooperacion"
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_art_ver_tipooperacion, lstr_param)
	END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event itemchanged;string v_Articulo

IF dwo.Name = "art_escandallo_articulo_ant" THEN
	select descripcion
	into :v_Articulo
	from articulos
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_escandallo.object.articulos_descripcion[row] = v_articulo

END IF  
end event

event rbuttondown;
bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "art_escandallo_articulo_ant"
		bus_titulo     = "AYUDA SELECCION ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "" 	

	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "art_escandallo_articulo_ant"
		bus_titulo     = "AYUDA SELECCION ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type cb_añadir3 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 2766
integer y = 2488
integer width = 782
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;long total_filas, fila_actual, nuevaoperacion, orden, indice
string ver

if dw_versiones.getrow() <= 0 then
	MessageBox("Error","Debe introducir una ruta en el apartado de versiones para poder Añadir en la tabla de Escandallo")
	return
end if

ver = dw_versiones.object.version[dw_versiones.getrow()]

if not isnull(ver) and ver <> '' then

	dw_escandallo.scrolltorow(dw_escandallo.InsertRow(0))
	dw_escandallo.SetColumn(1)
	
	fila_actual = dw_escandallo.Getrow()
	total_filas = dw_escandallo.RowCount()
	
	dw_escandallo.object.art_escandallo_empresa[fila_actual] = codigo_empresa
	dw_escandallo.object.art_escandallo_articulo[fila_actual] = sle_valor.text
	dw_escandallo.object.art_escandallo_version[fila_actual] = ver
else
	messagebox("Error", 'Número de versión no valido')
end if
end event

type r_2 from rectangle within w_mant_altas_intermedios_nuevo
integer linethickness = 4
long fillcolor = 33417450
integer x = 2761
integer y = 1804
integer width = 4219
integer height = 88
end type

type r_1 from rectangle within w_mant_altas_intermedios_nuevo
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8388608
integer x = 2720
integer y = 2928
integer width = 4219
integer height = 84
end type

type r_3 from rectangle within w_mant_altas_intermedios_nuevo
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 8388608
integer x = 18
integer y = 3784
integer width = 6935
integer height = 100
end type

type st_50 from statictext within w_mant_altas_intermedios_nuevo
integer x = 2757
integer y = 1928
integer width = 1577
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388736
boolean enabled = false
string text = "Escandallo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_duplicar_todo from commandbutton within w_mant_altas_intermedios_nuevo
string tag = "ATENCIÓN FACTOR ENCAJADO"
integer x = 3474
integer y = 212
integer width = 672
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Duplicar Todo (No fichero)"
end type

event clicked;String v_codigo, uso
Boolean duplicar_bases
transaction transaccion

if sle_valor.text = '' or isnull(sle_valor.text ) then
	MessageBox("Atención", "Introducir el artículo que se desea duplicar", Exclamation!, OK!) 
	return
end if

dw_imprimir_seleccionados.reset()
dw_articulo_inicial.reset()
dw_articulo_final.reset()
dw_referencias.reset()
dw_imprimir_seleccionados.visible = not dw_imprimir_seleccionados.visible
dw_articulo_inicial.visible = not dw_articulo_inicial.visible
dw_articulo_final.visible = not dw_articulo_final.visible
dw_referencias.visible = not dw_referencias.visible
dw_imprimir_seleccionados.object.b_imprimir.visible = false
dw_imprimir_seleccionados.object.b_nombres.visible = false
dw_imprimir_seleccionados.object.b_duplicar.visible = true
dw_imprimir_seleccionados.object.t_titulo.text = "Datos Nuevo Artículo"
dw_imprimir_seleccionados.object.t_primero.visible = true
dw_imprimir_seleccionados.object.t_ultimo.visible = true

if dw_articulo_inicial.visible then
	dw_articulo_inicial.insertrow(0)
	dw_articulo_final.insertrow(0)
	dw_referencias.insertrow(0)
	dw_referencias.setfocus()
end if


end event

type dw_versiones from u_datawindow within w_mant_altas_intermedios_nuevo
integer x = 2757
integer y = 1468
integer width = 4219
integer height = 332
integer taborder = 120
string dataobject = "dw_versiones_intermedios"
boolean vscrollbar = true
end type

event clicked;
dw_1.enabled = false
if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
	parent.TriggerEvent("ue_desactiva_claves")
	cb_insertar.enabled   = TRUE
end if
dw_1.enabled = True


If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event itemchanged;string v_juegopantallas, v_factormp, operacion

IF dwo.Name = "base" THEN
	dw_versiones.object.articulos_descripcion[row] = f_buscar_descripcion_articulo (data)
END IF

end event

event rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "base"
	valor_empresa = TRUE
	bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
	bus_datawindow = "dw_ayuda_articulos"
CASE "base2"
	valor_empresa = TRUE
	bus_titulo     = "VENTANA SELECCION DE ARTICULOS "
	bus_datawindow = "dw_ayuda_articulos"
	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event retrieveend;if this.rowcount() >0 then
   This.event rowfocuschanged(1)
end if

end event

event rowfocuschanged;call super::rowfocuschanged;
string ver, operacion, aplicacion

dw_escandallo.reset()
dw_operaciones.reset()
dw_aplicaciones.reset()

if currentrow <> 0 then
	ver =  dw_versiones.object.version[currentrow]
	dw_operaciones.retrieve (codigo_empresa, sle_valor.text, ver )
	dw_escandallo.retrieve (codigo_empresa, sle_valor.text, ver)
	
	If dw_operaciones.GetRow() > 0 Then 
	  dw_operaciones.SetRow(1)
	end if
end if



end event

event key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "base"
	valor_empresa = TRUE
	bus_titulo     = "VENTANA SELECCION ARTICULOS "
	bus_datawindow = "dw_ayuda_articulos"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

event losefocus;call super::losefocus;//integer v_tipo_version
//if dw_versiones.rowcount() > 0 then
//	if dw_versiones.object.tipo_version[dw_1.GetRow()] = 'P' then
//		select count(*)
//		into :v_tipo_version
//		from art_versiones
//		where empresa = :codigo_empresa
//		and articulo = :sle_valor.text
//		and tipo_version = 'P'
//		and version <> :sle_valor.text;
//		
//		if v_tipo_version >= 1 then
//			dw_versiones.object.tipo_version[dw_1.GetRow()] = 'A'
//			messagebox ("Aviso","La versión principal debe ser única")
//			dw_versiones.accepttext()
//		end if
//	end if
//	
//	if dw_versiones.object.tipo_version[dw_1.GetRow()] = '' then
//		messagebox ("Aviso","El tipo de versión es obligatorio")
//		dw_versiones.Setfocus()
//	end if
//end if	
//
//
//
end event

event doubleclicked;call super::doubleclicked;if dwo.name = 'observaciones' then
	mle_observaciones.text = this.object.observaciones[row] 
	mle_observaciones.visible = true
end if
end event

type pb_4 from upb_imprimir within w_mant_altas_intermedios_nuevo
integer x = 6551
integer y = 88
integer width = 123
integer height = 104
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean originalsize = false
string powertiptext = "Imprimir ficha técnica."
end type

event clicked;/*
string escandallo[],version_esc[],camino
long   indice,total,i
tipo_array val,ent

if trim(sle_valor.text) <> "" then
	ent.valor[1] = "1"
	ent.valor[2] = "1"
	openWithParm(w_pedir_version,ent)
	val =  message.powerObjectparm
	IF val.valor[1] = "RETURN" Then Return
		f_imprimir_ficha_tecnica_ot(dw_listado_ficha,sle_valor.text,val.valor[1],val.valor[2], 0)
		f_imprimir_datawindow(dw_listado_ficha)
end if
*/
if trim(sle_busqueda.text) <> "" then
	dw_imprimir_seleccionados.reset()
	dw_imprimir_seleccionados.visible = not dw_imprimir_seleccionados.visible
	dw_imprimir_seleccionados.object.b_imprimir.visible = true
	dw_imprimir_seleccionados.object.b_duplicar.visible = false
	dw_imprimir_seleccionados.object.b_nombres.visible = false
	dw_imprimir_seleccionados.object.t_titulo.text = "Imprimir Ficha"
	dw_imprimir_seleccionados.object.t_primero.visible = false
	dw_imprimir_seleccionados.object.t_ultimo.visible = false
end if
end event

type pb_anterior from picturebutton within w_mant_altas_intermedios_nuevo
integer x = 6674
integer y = 88
integer width = 114
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_open2.png"
alignment htextalign = left!
string powertiptext = "Desplazamiento hacia la base."
end type

event clicked;if dw_articulos_ant.visible then
	dw_articulos_ant.visible = false
elseif not cb_insertar.enabled then
		dw_articulos_ant.SetTransObject(SQLCA)
		dw_articulos_ant.visible = true
		dw_articulos_post.visible = false
		dw_articulos_ant.retrieve (codigo_empresa, sle_valor.text)
end if



end event

type pb_siguiente from picturebutton within w_mant_altas_intermedios_nuevo
integer x = 6784
integer y = 88
integer width = 114
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_open.png"
alignment htextalign = left!
string powertiptext = "Desplazamiento hacia el encajado."
end type

event clicked;if dw_articulos_post.visible then
	dw_articulos_post.visible = false
elseif not cb_insertar.enabled then
	dw_articulos_post.SetTransObject(SQLCA)
	dw_articulos_post.visible = true
	dw_articulos_ant.visible = false
	dw_articulos_post.retrieve (codigo_empresa, sle_valor.text)
end if

end event

type st_mensaje from statictext within w_mant_altas_intermedios_nuevo
integer x = 5746
integer y = 2348
integer width = 1257
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_mant_altas_intermedios_nuevo
integer x = 4032
integer y = 108
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom094!"
string powertiptext = "Borrar las mermas"
end type

event clicked;int rtn  = 1

IF Messagebox ("Aviso","Seuro que desea borrar las mermas de este artículo",exclamation!, yesno!) = 1 then

	UPDATE PRODPARTES_OT 
	SET art_terminado = 'N'
	where art_encajado = :sle_valor.text 
	using SQLCA;
	IF SQLCA.SQLCode <> 0 THEN 
		rtn = -1
	end if
	
	update art_Ver_operaciones 
	set coste_fab_mermas = 0, coste_mp_mermas = 0
	where articulo = :sle_valor.text using SQLCA;

	IF SQLCA.SQLCode <> 0 THEN 
		rtn = -1
	end if
	
	IF rtn = 1 THEN 
		Commit using SQLCA;
	else 
		messagebox("ERROR", "No se ha podido borrar el coste de las mermas")
		rollback using SQLCA;
	end if
end if

end event

type st_6 from statictext within w_mant_altas_intermedios_nuevo
integer x = 18
integer y = 112
integer width = 626
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Artículo Escandallo:"
boolean focusrectangle = false
end type

type dw_operaciones from u_datawindow within w_mant_altas_intermedios_nuevo
integer x = 2715
integer y = 2676
integer width = 4229
integer height = 240
integer taborder = 150
string dataobject = "dw_art_ver_operaciones"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;str_parametros lstr_param
string pantalla


dw_1.enabled = false
if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
	parent.TriggerEvent("ue_desactiva_claves")
	cb_insertar.enabled   = TRUE
end if
dw_1.enabled = True

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_tipooperacion"
			lstr_param.s_argumentos[1]  = "w_mant_art_ver_tipooperacion"
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_art_ver_tipooperacion, lstr_param)
		CASE "pb_formato"
			lstr_param.s_argumentos[1]  = "wi_mant_formatos"
    		lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_formatos, lstr_param)
		CASE "pb_pantallas"
			lstr_param.s_argumentos[1]  = "w_mant_juegospantallas"
			lstr_param.s_argumentos[2]  = dw_operaciones.object.art_ver_operaciones_juegopantallas[row] 
//			select codigo_pantallas
//			into :pantalla
//			from articulos
//			where empresa = :codigo_empresa
//			and codigo = :sle_valor.text;
			pantalla = dw_1.object.articulos_referencia_laboratorio[dw_1.getrow()]
			lstr_param.s_argumentos[3]  = pantalla
			lstr_param.i_nargumentos    = 4
			
			OpenWithParm(w_mant_juegospantallas, lstr_param)
	END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF



end event

event itemchanged;string v_juegopantallas, v_factormp, operacion
Decimal ancho, largo

IF dwo.Name = "tipo_operacion" THEN
	dw_operaciones.object.art_ver_tipooperacion_descripcion_abr[row] = f_buscar_tipooperacion (data)

END IF
IF dwo.Name = "art_ver_operaciones_formato" THEN
	dw_operaciones.object.formatos_descripcion[row] = f_nombre_formato (codigo_empresa,data)
	SELECT ancho, largo INTO :ancho, :largo FROM formatos WHERE empresa = :codigo_empresa AND codigo = :data;
	this.object.formatos_ancho[row] = ancho
	this.object.formatos_largo[row] = largo
	
END IF  
IF dwo.Name = "art_ver_operaciones_juegopantallas" THEN
	select descripcion
	into :v_juegopantallas
	from juegospantallas
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_operaciones.object.juegospantallas_descripcion[row] = v_juegopantallas

END IF  
IF dwo.Name = "art_ver_operaciones_coste" THEN
	operacion = dw_operaciones.object.tipo_operacion[row]
	select descripcion
	into :v_factormp
	from factormp
	where empresa = :codigo_empresa
	and operacion = :operacion
	and factor = :data;
	dw_operaciones.object.factormp_descripcion[row] = v_factormp  

END IF  

end event

event rbuttondown;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "tipo_operacion"
		bus_titulo     = "AYUDA SELECCION TIPOS DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_formato"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_juegopantallas"
		bus_titulo     = "AYUDA SELECCION DE JUEGOS DE PANTALLAS"
		bus_datawindow = "dw_ayuda_juegopantallas"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_coste"
		v_operacion = dw_operaciones.object.tipo_operacion[dw_operaciones.Getrow()]		
		bus_titulo     = "AYUDA SELECCION FACTOR MP POR OPERACION"
		bus_datawindow = "dw_ayuda_coste_mp_operacion"
		bus_filtro     = " operacion = '"+v_operacion+"' "	
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event retrieveend;if this.rowcount() >0 then
   This.event rowfocuschanged(1)
end if

end event

event rowfocuschanged;call super::rowfocuschanged;
string operacion, aplicacion, ver

dw_aplicaciones.reset()

if currentrow <> 0 then
	operacion = dw_operaciones.object.operacion[currentrow]
	ver = dw_versiones.object.version[dw_versiones.getrow()]
	dw_aplicaciones.retrieve(codigo_empresa, sle_valor.text, ver, operacion)
	If dw_aplicaciones.GetRow() > 0 Then 
	  dw_aplicaciones.SetRow(1)
	end if
end if



end event

event key;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "tipo_operacion"
		bus_titulo     = "AYUDA SELECCION TIPOS DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_formato"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_juegopantallas"
		bus_titulo     = "AYUDA SELECCION DE JUEGOS DE PANTALLAS"
		bus_datawindow = "dw_ayuda_juegospantallas"
		bus_filtro     = "" 	
	CASE "art_ver_operaciones_coste"
		v_operacion = dw_operaciones.object.tipo_operacion[dw_operaciones.Getrow()]		
		bus_titulo     = "AYUDA SELECCION FACTOR MP POR OPERACION"
		bus_datawindow = "dw_ayuda_coste_mp_operacion"
		bus_filtro     = " operacion = '"+v_operacion+"' "	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type sle_busqueda from singlelineedit within w_mant_altas_intermedios_nuevo
event key pbm_keydown
integer x = 567
integer y = 92
integer width = 1371
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

event key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

consulta_busqueda =  "SELECT articulos.codigo, CONVERT(char(60),articulos.descripcion), formatos.abreviado, art_ver_tipooperacion.descripcion_abr, oanterior.descripcion_abr, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
							"LEFT OUTER JOIN art_escandallo e1 ON articulos.empresa = e1.empresa AND articulos.codigo = e1.articulo AND e1.articulo_ant = (SELECT TOP 1 articulo_ant FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) AND e1.version = (SELECT TOP 1 version FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) "+&
							"LEFT OUTER JOIN articulos anterior ON e1.empresa = anterior.empresa AND e1.articulo_ant = anterior.codigo  "+&
							"LEFT OUTER JOIN art_ver_tipooperacion oanterior ON anterior.empresa = oanterior.empresa AND anterior.tipo_operacion = oanterior.codigo "+&  
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"articulos.fecha_anulado IS NULL AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"


busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Descripción"
busqueda.titulos[3] = "Formato"
busqueda.titulos[4] = "Operación"
busqueda.titulos[5] = "Anterior"
busqueda.titulos[6] = "Uso"
busqueda.titulos[7] = "Cliente"

IF not isnull(this.text) and this.text <> "" THEN
	//busqueda.filtro = this.text
	if Long(this.text) = 0 then
		//Es texto
		busqueda.filtro = this.text
		//busqueda.filtro_es_codigo = false
	else
		//Es código
		//busqueda.filtro_es_codigo = true
	end if
END IF

IF KeyDown(KeyEnter!) OR (not isnull(Message.LongParm) and Message.LongParm = 1001) THEN  
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado > 0 then
		this.text = resultado.valores[1]
		tv_escandallo.deleteitem(0)
		f_escandallo_treeview(this.text, 0, tv_escandallo)
		sle_valor.Text = this.text
		sle_valor.triggerEvent("tecla_tabulador")
	end if
END IF

end event

event losefocus;Long es_texto

if isnull(this.text) or trim(this.text) = "" then
	es_texto = 1
else
	es_texto = Long(this.text)
end if

if es_texto = 0 then
	IF KeyDown(KeyTab!) THEN
		this.triggerevent("key",0,1001)
	END IF
else
	IF KeyDown(KeyTab!) THEN
		tv_escandallo.deleteitem(0)
		f_escandallo_treeview(this.text, 0, tv_escandallo)
		sle_valor.Text = this.text
		sle_valor.triggerEvent("tecla_tabulador")
	END IF
end if

end event

type tv_escandallo from treeview within w_mant_altas_intermedios_nuevo
integer x = 37
integer y = 192
integer width = 2656
integer height = 2816
integer taborder = 190
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer indent = 2
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;/*
Treeviewitem tvi
String codigo_nuevo, codigo_version, descripcion
Long i, fila, versiones
Boolean existe = false
Decimal factor = 1

tv_escandallo.getitem(newhandle,tvi)
st_aplicaciones.text = " Aplicaciones:  " + tvi.label

//Messagebox("Codigo nuevo", Left(tvi.label, Pos(tvi.label,":")))
//codigo_nuevo = Left(tvi.label, Pos(tvi.label," :") - 1)
codigo_nuevo = Mid(tvi.label, Pos (tvi.label, "[") + 1,  ( Pos (tvi.label, "]") - Pos (tvi.label, "[")) - 1)   

if not isnull(codigo_nuevo) and codigo_nuevo <> "" then
	if dw_imprimir_seleccionados.visible then //Si se quiere imprimir no se cambia de codigo
		For i = 1 To dw_imprimir_seleccionados.rowcount()
			if codigo_nuevo = dw_imprimir_seleccionados.object.codigo[i] then
				existe = true
			end if
		Next
		if not existe then
			//Obtenemos datos necesarios para el vector de artículos
			//version 1 hasta que se prepare para más versiones
			codigo_version = "1"
			SELECT factor INTO :factor FROM art_escandallo WHERE empresa = :codigo_empresa AND articulo = :codigo_nuevo AND version = :codigo_version;
			//SELECT descripcion INTO :descripcion FROM articulos WHERE empresa = :codigo_empresa AND codigo = :codigo_nuevo;
			fila = dw_imprimir_seleccionados.insertrow(0)
			if fila > 0 then
				dw_imprimir_seleccionados.object.codigo[fila] = codigo_nuevo
				if fila = 1 then
					dw_imprimir_seleccionados.object.descripcion[fila] = ""
				else
					dw_imprimir_seleccionados.object.descripcion[fila] = dw_imprimir_seleccionados.object.descripcion[fila - 1]
				end if
				dw_imprimir_seleccionados.object.nivel[fila] = fila
				dw_imprimir_seleccionados.object.version[fila] = codigo_version
				dw_imprimir_seleccionados.object.factor[fila] = 0
				//dw_imprimir_seleccionados.object.factor[fila] = factor
			end if
		end if
	else
		sle_valor.text = codigo_nuevo
		sle_valor.TriggerEvent("tecla_tabulador")
	end if
end if
*/
end event

event rightclicked;long nodo
treeviewitem tvi
string articulo

tv_escandallo.getitem( handle, tvi)
openwithparm (wtc_crear_nodos , tvi.label)



end event

event key;long nodo_actual, nodo_siguiente
int li_tvret 


//IF key = KeyDownArrow! THEN
IF key = KeyF12! THEN	

	nodo_actual = tv_escandallo.FindItem(CurrentTreeItem! , 0)
	
	nodo_siguiente = tv_escandallo.FindItem(NextVisibleTreeItem! , nodo_actual)
	
	li_tvret = tv_escandallo.SelectItem(nodo_siguiente)
	
	tv_escandallo.setfocus( )

END IF

//IF key = KeyUpArrow! THEN
IF key = KeyF11! THEN

	nodo_actual = tv_escandallo.FindItem(CurrentTreeItem! , 0)
	
	nodo_siguiente = tv_escandallo.FindItem(PreviousVisibleTreeItem! , nodo_actual)
	
	li_tvret = tv_escandallo.SelectItem(nodo_siguiente)
	
	tv_escandallo.setfocus( )
	

END IF




end event

event clicked;Treeviewitem tvi
String codigo_nuevo, codigo_version, descripcion, operacion, nombre_art
Long i, fila, versiones
Boolean existe = false
Decimal factor = 1

tv_escandallo.getitem(handle,tvi)
st_aplicaciones.text = " Aplicaciones:  " + tvi.label

//Messagebox("Codigo nuevo", Left(tvi.label, Pos(tvi.label,":")))
//codigo_nuevo = Left(tvi.label, Pos(tvi.label," :") - 1)
codigo_nuevo = Mid(tvi.label, Pos (tvi.label, "[") + 1,  ( Pos (tvi.label, "]") - Pos (tvi.label, "[")) - 1)   

if not isnull(codigo_nuevo) and codigo_nuevo <> "" then
	if dw_imprimir_seleccionados.visible then //Si se quiere imprimir no se cambia de codigo
		For i = 1 To dw_imprimir_seleccionados.rowcount()
			if codigo_nuevo = dw_imprimir_seleccionados.object.codigo[i] then
				existe = true
			end if
		Next
		if not existe then
			//Obtenemos datos necesarios para el vector de artículos
			//version 1 hasta que se prepare para más versiones
			codigo_version = "1"
			
			SELECT factor INTO :factor FROM art_escandallo WHERE empresa = :codigo_empresa AND articulo = :codigo_nuevo AND version = :codigo_version;
			
			SELECT art_ver_tipooperacion.descripcion_abr INTO :operacion 
			FROM art_ver_tipooperacion 
			INNER JOIN art_ver_operaciones ON art_ver_operaciones.empresa = art_ver_tipooperacion.empresa AND art_ver_operaciones.tipo_operacion = art_ver_tipooperacion.codigo 
			INNER JOIN articulos ON art_ver_operaciones.empresa = articulos.empresa AND art_ver_operaciones.articulo = articulos.codigo 
			WHERE art_ver_tipooperacion.empresa = :codigo_empresa AND articulos.codigo = :codigo_nuevo;
			
			SELECT descripcion INTO :descripcion FROM articulos WHERE empresa = :codigo_empresa AND codigo = :codigo_nuevo;
			fila = dw_imprimir_seleccionados.insertrow(0)
			if fila > 0 then
				dw_imprimir_seleccionados.object.codigo[fila] = codigo_nuevo
				if dw_imprimir_seleccionados.object.t_titulo.text <> "Imprimir Ficha" then
					if fila = 1 then 
						nombre_art = ""
						if dw_articulo_inicial.rowcount() > 0 then
							nombre_art = dw_articulo_inicial.object.descripcion[dw_articulo_inicial.getrow()]
						end if
						dw_imprimir_seleccionados.object.descripcion[fila] = nombre_art
					else
						dw_imprimir_seleccionados.object.descripcion[fila] = dw_imprimir_seleccionados.object.descripcion[fila - 1]
					end if
				else
					dw_imprimir_seleccionados.object.descripcion[fila] = descripcion
				end if
				dw_imprimir_seleccionados.object.nivel[fila] = fila
				dw_imprimir_seleccionados.object.version[fila] = codigo_version
				dw_imprimir_seleccionados.object.factor[fila] = 0
				dw_imprimir_seleccionados.object.operacion[fila] = operacion
				//dw_imprimir_seleccionados.object.factor[fila] = factor
			end if
		end if
	else
		sle_valor.text = codigo_nuevo
		sle_valor.TriggerEvent("tecla_tabulador")
	end if
end if
end event

type cb_2 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 37
integer y = 3008
integer width = 645
integer height = 80
integer taborder = 280
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Expandir"
end type

event clicked;Long ll_tvi

ll_tvi = tv_escandallo.FindItem(RootTreeItem! , 0)
tv_escandallo.ExpandAll(ll_tvi)
end event

type cb_4 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 686
integer y = 3008
integer width = 613
integer height = 80
integer taborder = 320
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contraer"
end type

event clicked;long raiz, hijo, temporal 
int li_tvret

raiz = tv_escandallo.FindItem(RootTreeItem!, 0)
tv_escandallo.SelectItem(raiz)
temporal = tv_escandallo.FindItem(ChildTreeItem! , raiz)
do while (temporal <> -1)
	tv_escandallo.collapseItem(temporal)
	hijo = tv_escandallo.FindItem(ChildTreeItem! , temporal)
	f_contraer_tv(hijo)
	temporal	= 	tv_escandallo.FindItem(NextTreeItem!, temporal)
loop
end event

type st_aplicaciones from statictext within w_mant_altas_intermedios_nuevo
integer x = 37
integer y = 3120
integer width = 6912
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "   Aplicaciones"
boolean border = true
boolean focusrectangle = false
end type

type dw_articulos_ant from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 4622
integer y = 196
integer width = 1755
integer height = 608
integer taborder = 200
boolean bringtotop = true
string title = "none"
string dataobject = "dw_consulta_articulos_ant"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if this.rowcount() > 0 then
	sle_valor.text = this.object.art_escandallo_articulo_ant[row]
	sle_valor.triggerevent("tecla_tabulador")
end if
this.visible = false
end event

type pb_bloquear_1 from picturebutton within w_mant_altas_intermedios_nuevo
string tag = "Bloquear/Desbloquear articulo"
integer x = 3899
integer y = 108
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom016!"
alignment htextalign = left!
string powertiptext = "Bloquear/Desbloquear articulo"
end type

event clicked;int rtn = 1

if sle_valor.text <> "" and dw_1.rowcount() = 1 then
	if dw_1.object.articulos_bloqueado[1] = 'S' then
		update articulos
		set bloqueado = 'N'
		where empresa = :codigo_empresa
		and codigo = :sle_valor.text using sqlca;
		if sqlca.sqlcode <> 0 then
			rtn= -1
		end if		
	else
		update articulos
		set bloqueado = 'S'
		where empresa = :codigo_empresa
		and codigo = :sle_valor.text using sqlca;
		if sqlca.sqlcode <> 0 then
			rtn= -1
		end if		
	end if
	// Calculo del coste de las cajas
	if dw_1.object.articulos_uso[dw_1.GetRow()] = '3' then
		if dw_operaciones.RowCount() > 0 then
			dw_operaciones.object.art_ver_operaciones_coste_packing[dw_operaciones.GetRow()] = f_calculo_coste_packing (codigo_empresa, sle_valor.text)
		end if
	end if
	
	sle_valor.triggerEvent("tecla_tabulador")
end if

if rtn = 1 then 
	commit using sqlca;
else
	rollback using sqlca;
end if
end event

type pb_bloquear_estructura from picturebutton within w_mant_altas_intermedios_nuevo
string tag = "Bloquear/Desbloquear estructura"
integer x = 3776
integer y = 108
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom024!"
alignment htextalign = left!
string powertiptext = "Bloquear/Desbloquear estructura"
end type

event clicked;if sle_valor.text <> "" and dw_1.rowcount() = 1 then
	if dw_1.object.articulos_bloqueado[1] = 'S' then
		fr_bloquear(sle_valor.text,0)
	else
		fr_bloquear(sle_valor.text,1)
	end if
	sle_valor.triggerEvent("tecla_tabulador")
end if

// Calculo del coste de las cajas
if dw_1.object.articulos_uso[dw_1.GetRow()] = '3' then
	if dw_operaciones.RowCount() > 0 then
		dw_operaciones.object.art_ver_operaciones_coste_packing[dw_operaciones.GetRow()] = f_calculo_coste_packing (codigo_empresa, sle_valor.text)
	end if
end if

end event

type pb_2 from picturebutton within w_mant_altas_intermedios_nuevo
string tag = "Anular/Activar estructura"
integer x = 3529
integer y = 108
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "RetrieveCancel!"
alignment htextalign = left!
string powertiptext = "Anular/Activar estructura"
end type

event clicked;String fecha_anulado
if sle_valor.text <> "" and dw_1.rowcount() = 1 then
	fecha_anulado = String(dw_1.object.articulos_fecha_anulado[1])
	if isnull(fecha_anulado) or fecha_anulado = "" then
		if MessageBox("Aviso", "Se va a proceder a anular la estructura del artículo seleccionado.~n¿Está seguro de que desea continuar?~n~nPor favor, asegurese de que desea anular toda la estructura y no un artículo de forma individual.",Question!,YesNo!,2) = 2 then
			return
		end if
		fr_anular(sle_valor.text,1)
	else
		if MessageBox("Aviso", "Se va a proceder a la activación de la estructura del artículo seleccionado.~n¿Está seguro de que desea continuar?~n~nPor favor, asegurese de que desea activar toda la estructura y no un artículo de forma individual.",Question!,YesNo!,2) = 2 then
			return
		end if
		fr_anular(sle_valor.text,0)
	end if
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(sle_busqueda.text, 0, tv_escandallo)
	sle_valor.Text = sle_valor.Text
	sle_valor.triggerEvent("tecla_tabulador")
end if
end event

type pb_3 from picturebutton within w_mant_altas_intermedios_nuevo
string tag = "Anular/Activar articulo"
integer x = 3653
integer y = 108
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Custom080!"
alignment htextalign = left!
string powertiptext = "Anular/Activar articulo"
end type

event clicked;Datetime ahora
String descripcion, fecha_anulado
Long posicion
ahora = Datetime(Today(),Now())
int rtn
 
rtn = 1 
if sle_valor.text <> "" and dw_1.rowcount() = 1 then
	fecha_anulado = String(dw_1.object.articulos_fecha_anulado[1])
	if isnull(fecha_anulado) or fecha_anulado = "" then
		descripcion = trim(dw_1.object.articulos_descripcion[1])
		if pos(descripcion,"NULO") <> 1 then
			descripcion = "NULO "+descripcion		
		end if
		
		update articulos
		set 
				fecha_anulado = :ahora,
				descripcion = :descripcion
		where empresa = :codigo_empresa
				and codigo = :sle_valor.text 
		using sqlca;
		if sqlca.sqlcode <> 0 then
			rtn= -1
		end if
		
				
	else
		
		descripcion = trim(dw_1.object.articulos_descripcion[1])
		posicion = pos(descripcion,"NULO")
		if posicion = 1 then
			descripcion = trim(mid(descripcion, posicion+4))
		else
			if MessageBox("Aviso","La descripción del artículo "+sle_valor.text+" no contiene en su inicio la palabra NULO y no se quitará de la descripción si está en otra posición.~n¿Desea continuar de todas formas?",Question!,YesNo!,2) = 2 then
				return
			end if
		end if
		
		update articulos
		set 
				fecha_anulado = NULL,
				descripcion = :descripcion
		where empresa = :codigo_empresa
				and codigo = :sle_valor.text
		using sqlca;
		if sqlca.sqlcode <> 0 then
			rtn= -1
		end if
				
	end if
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(sle_busqueda.text, 0, tv_escandallo)
	sle_valor.Text = sle_valor.Text
	sle_valor.triggerEvent("tecla_tabulador")
end if

if rtn = 1 then
	commit using sqlca;
else
	rollback using sqlca;
end if
end event

type dw_imagen from u_dw_imagen within w_mant_altas_intermedios_nuevo
integer x = 5984
integer y = 1964
integer width = 800
integer height = 360
integer taborder = 170
end type

type cb_eliminar3 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 3561
integer y = 2488
integer width = 773
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Eliminar"
end type

event clicked;boolean error_borrando
long fila_actual, total_filas, indice
string registro, tipoaplicacion, contadoraplicacion

error_borrando = False

if dw_escandallo.Rowcount() > 0 then
	fila_actual = dw_escandallo.getrow()
//	registro = dw_escandallo.object.operacion[fila_Actual]
end if

// Borramos la operacion

if not error_borrando then
	dw_escandallo.DeleteRow(fila_actual)
	
//	if dw_escandallo.Update() = -1 then
//		error_borrando = True
//	end if
end if

if error_borrando then
	rollback;
end if

//dw_escandallo.retrieve(codigo_empresa,articulo, sle_valor.text)












end event

type st_5 from statictext within w_mant_altas_intermedios_nuevo
integer x = 2757
integer y = 2480
integer width = 1591
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388736
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_archivos_modelo from picturebutton within w_mant_altas_intermedios_nuevo
integer x = 5929
integer y = 2464
integer width = 146
integer height = 128
integer taborder = 210
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\index.png"
alignment htextalign = left!
string powertiptext = "Archivos del Modelo"
end type

event clicked;str_parametros lstr_param
long esta_abierta

//La ventana será response
if not isnull(sle_valor.Text) and sle_valor.Text <> "" then
	lstr_param.s_argumentos[1] = sle_valor.Text
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_mant_articulos_imagen_encajado"
	lstr_param.resultado = ''
	Openwithparm(wtc_mant_articulos_imagen_encajado, lstr_param)
end if

end event

type st_7 from statictext within w_mant_altas_intermedios_nuevo
integer x = 6121
integer y = 2492
integer width = 590
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Imágenes Artículos"
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 4215
integer y = 212
integer width = 654
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar Ruta"
end type

event clicked;if dw_ruta_duplicar.visible then
	dw_ruta_duplicar.visible = false
	dw_ruta_duplicar.reset()
else
	dw_ruta_duplicar.visible = true
	dw_ruta_duplicar.insertrow(0)
end if
end event

type dw_listado_ficha2 from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 901
integer y = 788
integer width = 1806
integer height = 1344
integer taborder = 290
boolean bringtotop = true
string title = "none"
string dataobject = "report_ficha_tecnica_operaciones2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_7 from commandbutton within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 4009
integer y = 76
integer width = 375
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Duplicar Todo (bases)"
end type

event clicked;String v_codigo, uso
Boolean duplicar_bases
transaction transaccion

if sle_valor.text = '' or isnull(sle_valor.text ) then
	MessageBox("Atención", "Introducir el artículo que se desea duplicar", Exclamation!, OK!) 
	return
end if

if MessageBox("Atención", "Se va a duplicar la estructura actual (solo ruta principal). ¿Continuar?", Exclamation!, YesNo!,2) = 2 then
	return
end if

f_crear_transaccion(transaccion,"","",false,"TS","")
CONNECT USING transaccion;

SELECT uso INTO :uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor.text;
if uso = "1" then
	duplicar_bases = true
else
	duplicar_bases = false
end if

v_codigo = fr_duplicar_con_estructura_nueva(sle_valor.text, "", "1", "", 1, transaccion, "", "", "", duplicar_bases)
if v_codigo <> "-1" then
	commit using transaccion;
	sle_valor.text = v_codigo
	sle_valor.triggerevent("tecla_tabulador")
	sle_busqueda.text = v_codigo
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(v_codigo, 0, tv_escandallo)
else
	rollback using transaccion;
	messagebox ("Error", "No se pudo duplicar el artículo")
end if
DISCONNECT USING transaccion;
destroy transaccion;
end event

type dw_articulo_inicial from u_dw within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 4165
integer y = 364
integer width = 1522
integer height = 76
integer taborder = 140
boolean bringtotop = true
string dataobject = "dwtc_aux_pruebas_duplicar_articulos"
end type

event usr_dwnkey;call super::usr_dwnkey;string campo, cliente
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
	//dw_1.EVENT usr_keydown(key, keyflags)
//end if

//control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "codigo"
			busqueda.consulta = "SELECT articulos.codigo, CONVERT(char(60),articulos.descripcion), formatos.abreviado, art_ver_tipooperacion.descripcion_abr, oanterior.descripcion_abr, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
							"LEFT OUTER JOIN art_escandallo e1 ON articulos.empresa = e1.empresa AND articulos.codigo = e1.articulo AND e1.articulo_ant = (SELECT TOP 1 articulo_ant FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) AND e1.version = (SELECT TOP 1 version FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) "+&
							"LEFT OUTER JOIN articulos anterior ON e1.empresa = anterior.empresa AND e1.articulo_ant = anterior.codigo  "+&
							"LEFT OUTER JOIN art_ver_tipooperacion oanterior ON anterior.empresa = oanterior.empresa AND anterior.tipo_operacion = oanterior.codigo "+&  
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"articulos.fecha_anulado IS NULL AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Formato"
			busqueda.titulos[4] = "Operación"
			busqueda.titulos[5] = "Anterior"
			busqueda.titulos[6] = "Uso"
			busqueda.titulos[7] = "Cliente"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.codigo[this.GetRow()] 			= resultado.valores[1]		
				this.object.descripcion[this.GetRow()] 	= resultado.valores[2]		
			end if
			
	END CHOOSE
end if	
	
end event

event itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "codigo"
		SELECT articulos.descripcion
		INTO :resultado
		FROM articulos
		WHERE empresa = :codigo_empresa
		and articulos.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE


this.Accepttext()
end event

type dw_articulo_final from u_dw within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 4165
integer y = 444
integer width = 1522
integer height = 76
integer taborder = 300
boolean bringtotop = true
string dataobject = "dwtc_aux_pruebas_duplicar_articulos"
end type

event itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "codigo"
		SELECT articulos.descripcion
		INTO :resultado
		FROM articulos
		WHERE empresa = :codigo_empresa
		and articulos.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE


this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, cliente
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
	//dw_1.EVENT usr_keydown(key, keyflags)
//end if

//control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "codigo"
			busqueda.consulta = "SELECT articulos.codigo, CONVERT(char(60),articulos.descripcion), formatos.abreviado, art_ver_tipooperacion.descripcion_abr, oanterior.descripcion_abr, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
							"LEFT OUTER JOIN art_escandallo e1 ON articulos.empresa = e1.empresa AND articulos.codigo = e1.articulo AND e1.articulo_ant = (SELECT TOP 1 articulo_ant FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) AND e1.version = (SELECT TOP 1 version FROM art_escandallo WHERE empresa = articulos.empresa AND articulo = articulos.codigo) "+&
							"LEFT OUTER JOIN articulos anterior ON e1.empresa = anterior.empresa AND e1.articulo_ant = anterior.codigo  "+&
							"LEFT OUTER JOIN art_ver_tipooperacion oanterior ON anterior.empresa = oanterior.empresa AND anterior.tipo_operacion = oanterior.codigo "+&  
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"articulos.fecha_anulado IS NULL AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Formato"
			busqueda.titulos[4] = "Operación"
			busqueda.titulos[5] = "Anterior"
			busqueda.titulos[6] = "Uso"
			busqueda.titulos[7] = "Cliente"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.codigo[this.GetRow()] 			= resultado.valores[1]		
				this.object.descripcion[this.GetRow()] 	= resultado.valores[2]		
			end if
			
	END CHOOSE
end if	
	
end event

type dw_referencias from u_dw within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 3227
integer y = 280
integer width = 2514
integer height = 84
integer taborder = 310
boolean bringtotop = true
string dataobject = "dwtc_aux_pruebas_duplicar_referencia"
end type

type cb_5 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 4937
integer y = 212
integer width = 654
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambio Nombres"
end type

event clicked;if dw_imprimir_seleccionados.visible then
	dw_imprimir_seleccionados.visible = false
	dw_imprimir_seleccionados.reset()
else
	dw_imprimir_seleccionados.reset()
	dw_imprimir_seleccionados.visible = true
	dw_imprimir_seleccionados.object.b_imprimir.visible = false
	dw_imprimir_seleccionados.object.b_duplicar.visible = false
	dw_imprimir_seleccionados.object.b_nombres.visible = true
	dw_imprimir_seleccionados.object.t_titulo.text = "Cambio de Nombre"
	dw_imprimir_seleccionados.object.t_primero.visible = false
	dw_imprimir_seleccionados.object.t_ultimo.visible = false
end if
end event

type p_imagen from picture within w_mant_altas_intermedios_nuevo
integer x = 5993
integer y = 1964
integer width = 814
integer height = 336
boolean focusrectangle = false
end type

type cb_8 from commandbutton within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 6304
integer y = 1788
integer width = 695
integer height = 236
integer taborder = 230
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Rellenar bases compras"
end type

event clicked;string sel
datastore datos
long i, total_regs
string articulo, formato



/*
sel = " select codigo, formato "+&
		" from articulos "+&
		" where codigo not in (select articulo from art_ver_operaciones) "+&
		" and promocion = 'N' "+&
		" and fecha_anulado is null "

		
		
f_cargar_cursor_nuevo( sel, datos)
total_regs = datos.rowcount()

for i = 1 to total_regs
	articulo = datos.object.codigo[i]
	formato = datos.object.formato[i]
	
	insert into art_ver_operaciones 	(empresa, articulo, version, operacion, tipo_operacion, orden, factor, formato)
	values ('1', :articulo, '1','1', '47','1',1, :formato) 
	using sqlca;
	commit using sqlca;
	st_contador.text = (string (i)+ " de " +string (total_regs))
next

destroy datos
	
*/	
end event

type st_contador from statictext within w_mant_altas_intermedios_nuevo
integer x = 1454
integer y = 1052
integer width = 1216
integer height = 156
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_copiar_parametros from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 5659
integer y = 212
integer width = 654
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar Parámetros Base"
end type

event clicked;String molde, plato_sup, plato_inf, costilla, familia, relieve, cliente, descripcion, formato
str_aux_parametros_base parametros

if isnull(sle_valor.text) or trim(sle_valor.text) = "" then
	return
end if

SELECT molde, plato_sup, plato_inf, costilla, familia, relieve, cliente, descripcion, espesor, espesor_lateral, pesopieza, marco
INTO :parametros.molde, :parametros.plato_sup, :parametros.plato_inf, :parametros.costilla, :parametros.familia, :parametros.relieve, 
		:parametros.cliente, :parametros.descripcion, :parametros.espesor, :parametros.espesor_lateral, :parametros.pesopieza, :parametros.marco
FROM articulos 
WHERE empresa = :codigo_empresa AND codigo = :sle_valor.text;

SELECT PT
INTO :parametros.pt
FROM art_codestadistico
WHERE empresa = :codigo_empresa AND codigo = :sle_valor.text;


if fr_cambio_parametros_base(parametros, sle_valor.text) = 1 then
	Messagebox("Operación completada con éxito", "Se han cambiado correctamente los parámetros para los artículos descendientes.")
else
	Messagebox("Error", "No se han podido realizar los cambios.")
end if

end event

type dw_cajas from datawindow within w_mant_altas_intermedios_nuevo
integer x = 4434
integer y = 1936
integer width = 1093
integer height = 404
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_articuloscaja_conjunto"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)
	CASE 'pb_carpeta'	
		lstr_param.s_titulo_ventana = "Mantenimiento de Cajas por Artículo"
		lstr_param.s_argumentos[2]  = sle_valor.text
		lstr_param.i_nargumentos    = 2
		OpenWithParm(wi_mant_articulocaja,lstr_param)
		dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
END CHOOSE

end event

type dw_ruta_duplicar from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 3255
integer y = 220
integer width = 1714
integer height = 520
integer taborder = 160
string title = "none"
string dataobject = "dwtc_aux_duplicar_ruta_alta_sem"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;String v_operacion, v_tipo_operacion, v_orden, v_formato_op, v_juegopantallas, v_orientacion, v_coste
Long v_numaplicaciones
Dec v_factor
string v_operacion_apl, v_contadoraplicacion, v_pantalla, v_formula, v_tipoaplicacion, v_orden_apl
string v_boquilla, v_ciclo, v_temp_sup, v_temp_inf, v_cortes, v_discos , v_referencia_laboratorio
dec v_gramaje, v_gram_7x20, v_densidad, v_viscosidad, v_piezas_fila, v_coste_fab, v_coste_mp
String v_archivo_disenyo_tipomaquina_disenyo, v_archivo_disenyo_codigo, v_archivo_disenyo_prueba

String articulo, version_actual, base, nueva_version, nombre_nueva_ruta, articulo_escandallo
String sel
Long i, rtn = 1, max_version = 0
Transaction transaccion
Datastore operaciones, aplicaciones

if dwo.name = "b_cancelar" then
	this.visible = false
	dw_ruta_duplicar.reset()
elseif dwo.name = "b_duplicar" then
	
	this.triggerevent("itemchanged")
	this.accepttext( )
	
	if sle_valor.text = "" or dw_versiones.getrow() <= 0 or isnull(this.object.articulo[1]) or this.object.articulo[1] = "" or isnull(this.object.ruta[1]) or this.object.ruta[1] = "" then
		Messagebox("Error", "Debe completar todos los campos para crear la nueva ruta y tener seleccionada la ruta a duplicar.")
		return
	end if
	
	articulo = sle_valor.text
	version_actual = dw_versiones.object.version[dw_versiones.getrow()]
	base = this.object.articulo[1]
	nombre_nueva_ruta = this.object.ruta[1]
	articulo_escandallo = sle_busqueda.text
	
	f_crear_transaccion(transaccion,"","",false,"TS","")
	CONNECT USING transaccion;
	
	SELECT MAX(version) INTO :max_version FROM art_versiones WHERE empresa = :codigo_empresa AND articulo = :articulo USING transaccion;
	if transaccion.SQLCode <> 0 then 
		rtn = 0
	end if	
	max_version = max_version + 1
	nueva_version = String(max_version)
	
	if rtn = 1 then
		INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor)
		SELECT empresa, articulo, :nueva_version, :base, factor 
		FROM art_escandallo 
		WHERE empresa = :codigo_empresa AND articulo = :articulo AND version = :version_actual
		USING transaccion;
		if transaccion.SQLCode <> 0 then 
			rtn = 0
		end if	
	end if
	
	if rtn = 1 then
		INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, aprovechar_base, tipo_version)
		SELECT empresa, articulo, :nueva_version, :base, :nombre_nueva_ruta, observaciones, aprovechar_base, 'A' 
		FROM art_versiones 
		WHERE empresa = :codigo_empresa AND articulo = :articulo AND version = :version_actual
		USING transaccion;
		if transaccion.SQLCode <> 0 then 
			rtn = 0
		end if	
	end if
	
	if rtn = 1 then
		sel = "select operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila, coste_fab, coste_mp  "+&
				" from art_ver_operaciones "+&
				" where empresa = "+codigo_empresa+&
				" and articulo = "+articulo+&
				" and version = "+version_actual;
				
		f_cargar_cursor_trans(transaccion, sel, operaciones)
		
		for i = 1 to operaciones.rowcount() 
			
			v_operacion = operaciones.object.operacion[i]
			v_tipo_operacion = operaciones.object.tipo_operacion[i]
			v_orden = operaciones.object.orden[i]
			v_formato_op = operaciones.object.formato[i]
			v_factor = 1
			v_juegopantallas = operaciones.object.juegopantallas[i]
			v_numaplicaciones = operaciones.object.numaplicaciones[i]
			v_coste = operaciones.object.coste[i]
			v_orientacion = operaciones.object.orientacion[i]
			v_piezas_fila = operaciones.object.piezas_fila[i]
			v_coste_fab = operaciones.object.coste_fab[i]
			v_coste_mp = operaciones.object.coste_mp[i]
			
			insert into
				art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila, coste_fab, coste_mp)
			values
				(:codigo_empresa, :articulo, :nueva_version, :v_operacion, :v_tipo_operacion, :v_orden, :v_formato_op,  :v_factor, 
				:v_juegopantallas, :v_numaplicaciones, :v_coste, :v_orientacion, :v_piezas_fila, :v_coste_fab, :v_coste_mp) 
			using transaccion;
			
			if transaccion.SQLCode <> 0 then 
				rtn = 0
			end if
		next
	end if
	
	if rtn = 1 then
		sel = " select operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, orden, densidad, viscosidad, "+&
				" boquilla, ciclo, temp_sup, temp_inf, cortes, discos, orientacion, piezas_fila, archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba "+&
				" from art_ver_op_aplicaciones "+&
				" where empresa = "+codigo_empresa+&
				" and articulo = "+articulo+&
				" and version = "+version_actual;
				
		f_cargar_cursor_trans(transaccion, sel, aplicaciones)
		
		for i = 1 to aplicaciones.rowcount()
			
			v_operacion_apl = aplicaciones.object.operacion[i]
			v_contadoraplicacion = aplicaciones.object.contadoraplicacion[i]
			v_pantalla = aplicaciones.object.pantalla[i]
			v_formula = aplicaciones.object.formula[i]
			v_tipoaplicacion = aplicaciones.object.tipoaplicacion[i]
			v_orden_apl = aplicaciones.object.orden[i]	
			v_boquilla = aplicaciones.object.boquilla[i]
			v_ciclo = aplicaciones.object.ciclo[i]
			v_temp_sup = aplicaciones.object.temp_sup[i]
			v_temp_inf = aplicaciones.object.temp_inf[i]
			v_cortes = aplicaciones.object.cortes[i]
			v_discos = aplicaciones.object.discos[i]
			v_gramaje = aplicaciones.object.gramaje[i]
			v_gram_7x20 = aplicaciones.object.gram_7x20[i]
			v_densidad = aplicaciones.object.densidad[i]
			v_viscosidad = aplicaciones.object.viscosidad[i]
			v_orientacion = aplicaciones.object.orientacion[i]
			v_piezas_fila = aplicaciones.object.piezas_fila[i]
			v_archivo_disenyo_tipomaquina_disenyo  = aplicaciones.object.archivo_disenyo_tipomaquina_disenyo[i]
			v_archivo_disenyo_codigo  = aplicaciones.object.archivo_disenyo_codigo[i]
			v_archivo_disenyo_prueba  = aplicaciones.object.archivo_disenyo_prueba[i]
			
			insert into
				art_ver_op_aplicaciones (empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, gram_7x20, tipoaplicacion, 
												orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, orientacion, piezas_fila,  
												archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba)
			values
				(:codigo_empresa, :articulo, :nueva_version, :v_operacion_apl, :v_contadoraplicacion, :v_pantalla, :v_formula, :v_gramaje, :v_gram_7x20, :v_tipoaplicacion,
				:v_orden_apl, :v_densidad, :v_viscosidad, :v_boquilla, :v_ciclo, :v_temp_sup, :v_temp_inf, :v_cortes, :v_discos, :v_orientacion, :v_piezas_fila,
				 :v_archivo_disenyo_tipomaquina_disenyo, :v_archivo_disenyo_codigo, :v_archivo_disenyo_prueba) 
			using transaccion;
			
			if transaccion.SQLCode <> 0 then 
				rtn = 0
			end if
			
		next
	end if
	
	if rtn = 1 then
		COMMIT USING transaccion;
	else
		ROLLBACK USING transaccion;
		MessageBox("Error", "No se ha realizado la copia de ruta")
	end if
	DISCONNECT USING transaccion;
	
	this.visible = false
	dw_ruta_duplicar.reset()
	
	tv_escandallo.deleteitem(0)
	f_escandallo_treeview(articulo_escandallo, 0, tv_escandallo)
	sle_busqueda.text = articulo_escandallo
	sle_valor.text = articulo
	sle_valor.triggerevent("tecla_tabulador")
	
end if

Destroy transaccion
Destroy operaciones
Destroy aplicaciones
end event

event itemchanged;String res
if row > 0 then
	if dwo.name = "articulo" then
		SELECT descripcion INTO :res FROM articulos WHERE empresa = :codigo_empresa AND codigo = :data;
		if SQLCA.sqlcode <> 100 then
			this.object.descripcion[row] = res
		else
			dwo.Primary[row] = ''
			this.object.descripcion[Row] 		= ''
			return 2			
		end if
		
	end if
end if
end event

type mle_observaciones from multilineedit within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 4151
integer y = 788
integer width = 2222
integer height = 548
integer taborder = 270
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 30337023
end type

event rbuttondown;dw_versiones.object.observaciones[dw_versiones.getrow()] = this.text
this.visible = false
end event

type dw_imagenes_modelo from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 4741
integer y = 292
integer width = 1129
integer height = 1372
integer taborder = 90
string title = "none"
string dataobject = "dwtc_aux_imagenes_modelos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String codigo

if row > 0 then
	codigo = this.object.codigo[row]
	dw_1.object.articulos_imagen_origen[dw_1.getrow()] = codigo
	this.visible = false
end if
end event

event buttonclicked;if dwo.name = "b_cerrar" then
	this.visible = false
end if
end event

type dw_articulos_post from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 4626
integer y = 192
integer width = 1755
integer height = 608
integer taborder = 240
string title = "none"
string dataobject = "dw_consulta_articulos_post"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if this.rowcount() > 0 then
	sle_valor.text = this.object.art_escandallo_articulo[row]
	sle_valor.setfocus()
	sle_valor.triggerevent("tecla_tabulador")
end if
this.visible = false



end event

type dw_2 from datawindow within w_mant_altas_intermedios_nuevo
integer x = 2830
integer y = 1100
integer width = 677
integer height = 132
integer taborder = 300
boolean bringtotop = true
string title = "none"
string dataobject = "dw_codestadistico"
boolean border = false
boolean livescroll = true
end type

type cb_9 from commandbutton within w_mant_altas_intermedios_nuevo
integer x = 6382
integer y = 212
integer width = 654
integer height = 128
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grupos combinados"
end type

event clicked;str_parametros lstr_param



lstr_param.i_nargumentos    = 2
//lstr_param.s_argumentos[1]  = "wi_mant_articulos_conjunto_nuevo"

lstr_param.s_argumentos[2]  = sle_valor.Text
 
OpenWithParm(w_mant_articulos_tencer,lstr_param)  



end event

type dw_imprimir_seleccionados from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 3214
integer y = 196
integer width = 2606
integer height = 1832
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_impresion_ficha_articulos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;String v_codigo, uso, articulo_a_duplicar, referencia_lab, modelo_origen, descripcion, articulo_a_enlazar, base_version
Boolean duplicar_bases, error_enlazar = false
//transaction transaccion
Long i, num_versiones
Dec factor


if dwo.name = "b_cancelar" then
	this.visible = false
	this.reset()
	dw_articulo_inicial.visible = false
	dw_articulo_final.visible = false
	dw_referencias.visible = false
	dw_articulo_inicial.reset()
	dw_articulo_final.reset()
	dw_referencias.reset()
elseif dwo.name = "b_imprimir" then
	//ficha_prod
	ftc_imprimir_ficha_tecnica_completa(2)
elseif dwo.name = "b_imprimir2" then
	ftc_imprimir_ficha_tecnica_completa_old(2)
elseif dwo.name = "b_nombres" then
	f_cambiar_nombres()
elseif dwo.name = "b_duplicar" then
	//Comprobaciones previas
	if this.rowcount() <= 0 then
		MessageBox("Atención", "Debe seleccionar al menos un artículo para duplicar.")
		return
	end if
	
	For i = 1 to this.rowcount()
		factor = this.object.factor[i]
		if isnull(factor) or factor = 0 then
			MessageBox("Atención", "Debe completar el factor de todos los artículos para continuar")
			return
		end if
		
		descripcion = this.object.descripcion[i]
		if isnull(descripcion) or descripcion = "" then
			MessageBox("Atención", "Debe completar la descripción de todos los artículos para continuar")
			return
		end if
	next
	
	referencia_lab = dw_referencias.object.ant_modelo[1]
	if isnull(referencia_lab) or referencia_lab = "" then
		modelo_origen = dw_referencias.object.modelo[1]
		if isnull(modelo_origen) or modelo_origen = "" then
			MessageBox("Atención", "Debe completar la referencia de laboratorio")
			return
		end if
	end if
	
	/*
	if MessageBox("Atención", "Se va a duplicar la estructura actual (solo ruta principal). ¿Continuar?", Exclamation!, YesNo!,2) = 2 then
		return
	end if
	*/
	
	//Duplicar
	articulo_a_duplicar = dw_imprimir_seleccionados.object.codigo[1]
	
	v_codigo = fr_duplicar_estructura_dw(articulo_a_duplicar, "", "1", "", 1, trans_ts, "", "", "", 1)
	if v_codigo <> "-1" then
		
		//Enlazar articulo superior si se ha definido
		articulo_a_enlazar = dw_articulo_inicial.object.codigo[1]
		if not isnull(articulo_a_enlazar) and articulo_a_enlazar <> "" then
			insert into
			art_escandallo (empresa, articulo, version, articulo_ant,  factor)
			values
				(:codigo_empresa, :articulo_a_enlazar, "1", :v_codigo, 1 ) 
			using trans_ts;
			
			if trans_ts.SQLCode <> 0 then 
				MessageBox("Error", "Error enlazar superior, insert art_escandallo "+ trans_ts.SQLErrText) 
				rollback using trans_ts;
				error_enlazar = true
			end if	
			
			if not error_enlazar then
				SELECT count(*) 
				INTO :num_versiones 
				FROM art_versiones 
				WHERE empresa = :codigo_empresa 
					AND articulo = :articulo_a_enlazar 
					AND version = "1" 
				using trans_ts;
				
				if num_versiones = 1 then
					base_version = ""
					SELECT base 
					INTO :base_version 
					FROM art_versiones 
					WHERE empresa = :codigo_empresa 
						AND articulo = :articulo_a_enlazar 
						AND version = "1" 
					using trans_ts;
					
					if isnull(base_version) or base_version = "" then
						UPDATE art_versiones SET 
						base = :v_codigo, 
						descripcion = 'ÚNICA',
						tipo_version = 'P',
						observaciones = ''
						WHERE empresa = :codigo_empresa 
							AND articulo = :articulo_a_enlazar 
							AND version = "1"
						using trans_ts;
					end if
				elseif num_versiones = 0 then
					insert into
						art_versiones ( empresa, articulo, version, descripcion, observaciones, tipo_version, base)
					values
						(:codigo_empresa, :articulo_a_enlazar, "1", "ÚNICA", "", "P", :v_codigo) 
					using trans_ts;
						
					if trans_ts.SQLCode <> 0 then 
						MessageBox("Error", "Error enlazar superior, insert art_versiones "+ trans_ts.SQLErrText) 
						rollback using trans_ts;
						error_enlazar = true
					end if
				end if
			end if
			v_codigo = articulo_a_enlazar
		end if
		
		if not error_enlazar then
			commit using trans_ts;
			sle_valor.text = v_codigo
			sle_valor.triggerevent("tecla_tabulador")
			sle_busqueda.text = v_codigo
			tv_escandallo.deleteitem(0)
			f_escandallo_treeview(v_codigo, 0, tv_escandallo)
		end if
	else
		rollback using trans_ts;
		messagebox ("Error", "No se pudieron duplicar los artículos seleccionados")
	end if
	
	this.visible = false
	dw_articulo_inicial.visible = false
	dw_articulo_final.visible = false
	dw_referencias.visible = false
	this.reset()
	dw_articulo_inicial.reset()
	dw_articulo_final.reset()
	dw_referencias.reset()
end if

//if messagebox("Aviso", " ¿Desea abrir el alta comercial? ", Question!, YesNO!, 1) = 1 then
//	lstr_param.s_argumentos[1]  = "w_mant_altas_comercial"
//	lstr_param.s_argumentos[2]  = v_codigo 
//	lstr_param.i_nargumentos    = 3
//end if
//
end event

event clicked;if row > 0 and dwo.name = "p_borrar" then
	this.deleterow(row)
end if
end event

type dw_listado_ficha3 from datawindow within w_mant_altas_intermedios_nuevo
boolean visible = false
integer x = 384
integer y = 680
integer width = 1783
integer height = 1684
integer taborder = 310
boolean bringtotop = true
string title = "none"
string dataobject = "report_ficha_tecnica_operaciones3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

