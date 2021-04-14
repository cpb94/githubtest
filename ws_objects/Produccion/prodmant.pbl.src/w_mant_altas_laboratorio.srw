$PBExportHeader$w_mant_altas_laboratorio.srw
forward
global type w_mant_altas_laboratorio from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_altas_laboratorio
end type
type dw_codestadistico from u_datawindow within w_mant_altas_laboratorio
end type
type dw_observacion_version from u_datawindow within w_mant_altas_laboratorio
end type
type dw_calidad_altas from u_datawindow within w_mant_altas_laboratorio
end type
type cb_3 from commandbutton within w_mant_altas_laboratorio
end type
type dw_listado_ficha from datawindow within w_mant_altas_laboratorio
end type
type dw_2 from datawindow within w_mant_altas_laboratorio
end type
type dw_3 from datawindow within w_mant_altas_laboratorio
end type
type pb_4 from upb_imprimir within w_mant_altas_laboratorio
end type
type cb_5 from commandbutton within w_mant_altas_laboratorio
end type
type st_4 from statictext within w_mant_altas_laboratorio
end type
type uo_articulo from u_em_campo_2 within w_mant_altas_laboratorio
end type
type pb_duplicar from picturebutton within w_mant_altas_laboratorio
end type
type dw_versiones from u_datawindow within w_mant_altas_laboratorio
end type
type st_2 from statictext within w_mant_altas_laboratorio
end type
type st_50 from statictext within w_mant_altas_laboratorio
end type
type dw_escandallo from u_datawindow within w_mant_altas_laboratorio
end type
type cb_añadir3 from commandbutton within w_mant_altas_laboratorio
end type
type cb_eliminar3 from commandbutton within w_mant_altas_laboratorio
end type
type r_4 from rectangle within w_mant_altas_laboratorio
end type
type r_3 from rectangle within w_mant_altas_laboratorio
end type
type p_imagen from picture within w_mant_altas_laboratorio
end type
type pb_desbloquear from picturebutton within w_mant_altas_laboratorio
end type
type pb_1 from picturebutton within w_mant_altas_laboratorio
end type
type pb_importar from picturebutton within w_mant_altas_laboratorio
end type
type st_mensaje from statictext within w_mant_altas_laboratorio
end type
type cb_2 from commandbutton within w_mant_altas_laboratorio
end type
type r_1 from rectangle within w_mant_altas_laboratorio
end type
type dw_imagen from u_dw_imagen within w_mant_altas_laboratorio
end type
end forward

global type w_mant_altas_laboratorio from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3666
integer height = 2756
pb_calculadora pb_calculadora
dw_codestadistico dw_codestadistico
dw_observacion_version dw_observacion_version
dw_calidad_altas dw_calidad_altas
cb_3 cb_3
dw_listado_ficha dw_listado_ficha
dw_2 dw_2
dw_3 dw_3
pb_4 pb_4
cb_5 cb_5
st_4 st_4
uo_articulo uo_articulo
pb_duplicar pb_duplicar
dw_versiones dw_versiones
st_2 st_2
st_50 st_50
dw_escandallo dw_escandallo
cb_añadir3 cb_añadir3
cb_eliminar3 cb_eliminar3
r_4 r_4
r_3 r_3
p_imagen p_imagen
pb_desbloquear pb_desbloquear
pb_1 pb_1
pb_importar pb_importar
st_mensaje st_mensaje
cb_2 cb_2
r_1 r_1
dw_imagen dw_imagen
end type
global w_mant_altas_laboratorio w_mant_altas_laboratorio

type variables

end variables

forward prototypes
public subroutine f_valorar_stock ()
public subroutine f_calculos_caja ()
public function boolean f_enlazar_escandallo (string padre, string hijo, decimal factor, string v_version)
public function boolean f_duplicar_estructura (string padre, string padre_c, string descripcion, string referencia_lab, integer version_lab, string codigo_pantallas)
public function boolean f_duplicar_articulo (string origen, string destino, string descripcion_art, string referencia_lab, integer version_lab, ref string codigo_pantallas)
end prototypes

public subroutine f_valorar_stock ();
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



//// Extraemos parametros del código estadístico
//select g2, g3
//into :v_g2, :v_g3
//from art_codestadistico
//where empresa = :codigo_empresa
//and codigo = :sle_valor.text;

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
				:articulo_calidad, :v_familia, :v_formato, "S", "S", :v_usuario, :des_articulo, "N", "2");
else
	if MessageBox("Atención", "La tarifa valorada ya existe. ¿Desea actualizarla?.", Question!, YesNo!, 2) = 1 then
		update venlintarifas
		set fecha = :v_fecha_tar_activa, precio = :v_precio
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text
		and tarifa  = "5";
	end if
end if



end subroutine

public subroutine f_calculos_caja ();/*
Dec{4} peso_caja,peso_envase,peso_piezas,metros_caja,metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho
String cod_formato, var_caja, unidad

select piezascaja, caja
into :var_piezas, :var_caja
from almartcajas
where empresa = :codigo_empresa
and articulo = :sle_valor.text
and pordefecto = 'S';

var_peso_pieza = dw_1.object.pesopieza[dw_1.Getrow()]

var_peso_pieza  = f_peso_articulo (codigo_empresa,sle_valor.text)

peso_piezas = var_peso_pieza  * var_piezas
peso_envase     = f_peso_envase(codigo_empresa, var_caja)
peso_caja     = peso_envase + peso_piezas

cod_formato = f_formato_articulo (codigo_empresa,sle_valor.text)

//var_largo = f_largo_formato(codigo_empresa,cod_formato)
//var_ancho = f_ancho_formato(codigo_empresa,cod_formato)


select ancho_std, largo_std , unidad
into :var_ancho, :var_largo, :unidad
from articulos
where empresa = :codigo_empresa
and codigo = :sle_valor.text;


metros_caja  = (var_piezas * var_largo * var_ancho) / 10000
metrosl_caja = (var_piezas * var_largo) / 100


if unidad = '1' then
	metros_caja = round(metros_caja, ftc_decimales_articulo(codigo_empresa, sle_valor.text))
else
	metros_caja = round(metros_caja, 4)
end if		



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
*/
end subroutine

public function boolean f_enlazar_escandallo (string padre, string hijo, decimal factor, string v_version);boolean exito = true

insert into art_escandallo (empresa, articulo, articulo_ant, factor, version) 
values (:codigo_empresa, :padre, :hijo, :factor, :v_version);

if SQLCA.SQLCode = -1 then
	exito = false
	messagebox("Error en f_emlazar_escadallo", "Error al insertar en la tabla de escandallo.")
END IF

if exito then
	update art_versiones
	set base = :hijo
	where empresa = :codigo_empresa
	and articulo = :padre
	and version = '1';

	if SQLCA.SQLCode = -1 then
		exito = false
		messagebox("Error en f_emlazar_escadallo", "Error al actualizar el campo base de la ruta.")
	END IF
end if


return exito
end function

public function boolean f_duplicar_estructura (string padre, string padre_c, string descripcion, string referencia_lab, integer version_lab, string codigo_pantallas);long i, m, total_regs, k
string consulta_anteriores, v_uso, v_uso_padre, v_control_stock, v_uso_hijo,  hijo_c
datastore registros
string hijo[], v_version[]
dec factor[25]
boolean exito

consulta_anteriores = 	" select articulo_ant, factor, version "+&
								" from art_escandallo "+&
								" where empresa = '"+codigo_empresa+"' "+&
								" and articulo = '"+padre+"' "
								
f_cargar_cursor_nuevo (consulta_anteriores, registros)
total_regs = registros.rowcount()

for m = 1 to total_regs
	hijo[m] = registros.object.articulo_ant[m]
	factor[m] = registros.object.factor[m]
	v_version[m] = registros.object.version[m]
next

for i = 1 to total_regs
	select uso, control_stock
	into :v_uso_hijo, :v_control_stock
	from articulos
	where empresa = :codigo_empresa
	and codigo = :hijo[i];
	
	//if not ( v_uso_hijo = '1' or ( v_uso_hijo = '2' and v_control_stock = 'S' ) ) then //Diego 09-01-2015
	if not ( v_uso_hijo = '1') then
		hijo_c =  string(f_buscar_codigo_Articulo())
		f_duplicar_articulo (hijo[i], hijo_c, descripcion, referencia_lab, version_lab, codigo_pantallas)
	
		f_duplicar_estructura (hijo[i], hijo_c, descripcion, referencia_lab, version_lab, codigo_pantallas)
	else
		hijo_c = hijo[i]
	end if

	exito = f_enlazar_escandallo (padre_c, hijo_c, factor[i], v_version[i])
next

destroy registros
return exito


end function

public function boolean f_duplicar_articulo (string origen, string destino, string descripcion_art, string referencia_lab, integer version_lab, ref string codigo_pantallas);datastore operaciones, escandallo
string v_codigo, v_familia, v_formato, v_unidad, v_cuenta, v_sector, v_tono, v_calibre, v_compras, v_activo, v_prev_anular, relieve, costilla, marco
string v_molde, v_plato_sup, v_plato_inf, v_cliente, v_control_stock, v_usuario, v_calidad
dec v_pesopieza, v_espesor
dec{0} registros
datetime v_fecha_alta
boolean bien = true
string v_caja, v_codigopallet, v_caja2 
dec v_piezascaja, v_metroscaja, v_metroslcaja, v_pesocaja, v_metros_reales
int v_cajaspallet, v_planospallet, v_alturas
string v_g1, v_g2, v_g3, v_g4, v_pt, v_gd, v_nc, v_re, v_ee, v_av, v_pl, v_ct, v_en, v_tm, v_otr, v_n, v_inkcid
string v_version, v_base, v_base2, descripcion, v_observaciones, v_articulo_ant, v_aprovecha_esc, v_coleccion, v_color, v_uso
int v_factor_base
string v_operacion, v_tipo_operacion, v_orden, v_formato_op, v_juegopantallas, v_descripcion_ver
int v_numaplicaciones
dec v_factor,  v_factor_Esc, i, j, v_piezas_fila, v_paso_cliche, v_gram_7x20
string sel, v_marco, v_marcado, v_canto_vivo, v_tipo_version, v_coste, v_orientacion
String modelo_origen, pieza_origen, prueba_origen, archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba
/////////////// Cáclulo del coste //////////////
dec coste_mp_operacion
string operacion, ver
datastore  regs_coste
long m
////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
string articulo, v_contadoraplicacion, v_pantalla, v_formula, v_tipoaplicacion, v_ordenapl, v_boquilla, v_ciclo
string v_temp_sup, v_temp_inf, v_cortes, v_discos 
boolean exito
datastore aplicaciones
decimal v_gramaje, v_densidad, v_viscosidad
string v_marcas_codigo, v_submarcas_codigo
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if origen = '' or isnull(origen) then
	MessageBox("Atención", "Introducir el artículo que se desea duplicar", Exclamation!, OK!) 
	return false
end if

v_fecha_alta  = datetime(today(), now())
v_usuario = nombre_usuario
v_calidad = '1'
v_version = '1'

v_codigo = destino

select familia, marcas_codigo, submarcas_codigo, formato, unidad, sector, tono, calibre, compras, activo, prev_anular, molde, 
		plato_sup, plato_inf, cliente, codigo_pantallas, control_stock, pesopieza, espesor, coleccion, color, uso, marcado, canto_vivo, modelo_origen, pieza_origen, prueba_origen, relieve, costilla, marco
into :v_familia, :v_marcas_codigo, :v_submarcas_codigo, :v_formato, :v_unidad, :v_sector, :v_tono, :v_calibre, :v_compras, :v_activo, :v_prev_anular, :v_molde, 
	:v_plato_sup, :v_plato_inf, :v_cliente, :codigo_pantallas, :v_control_stock, :v_pesopieza, :v_espesor, :v_coleccion, :v_color, :v_uso,
	:v_marcado, :v_canto_vivo, :modelo_origen, :pieza_origen, :prueba_origen	, :relieve, :costilla, :marco
from articulos
where empresa = :codigo_empresa
and codigo = :origen;

select caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales
into :v_caja, :v_piezascaja, :v_metroscaja, :v_metroslcaja, :v_pesocaja, :v_metros_reales
from almartcajas
where empresa = :codigo_empresa
and articulo = :origen
and pordefecto = 'S';

select codigo, caja, cajaspallet, planospallet, alturas
into :v_codigopallet, :v_caja2, :v_cajaspallet, :v_planospallet, :v_alturas
from palarticulo
where empresa = :codigo_empresa
and articulo = :origen
and pordefecto = 'S';

select g1, g2, g3, g4, pt, gd, nc, re, rectificado, av, pl, ct, en, tm, otr, n, inkcid
into :v_g1, :v_g2, :v_g3, :v_g4, :v_pt, :v_gd, :v_nc, :v_re, :v_ee, :v_av, :v_pl, :v_ct, :v_en, :v_tm, :v_otr, :v_n, :v_inkcid
from art_codestadistico
where empresa = :codigo_empresa
and codigo = :origen;

select base,  descripcion, observaciones, tipo_version
into :v_base, :v_descripcion_ver, :v_observaciones, :v_tipo_version
from art_versiones
where empresa = :codigo_empresa
and articulo = :origen
and version = :v_version;

connect using SQLCA;
insert into 	
	articulos (empresa, codigo, descripcion, fecha_alta, familia, marcas_codigo, submarcas_codigo, formato, unidad, sector, tono, calibre, compras, activo, 
	prev_anular, molde, plato_sup, plato_inf, cliente, codigo_pantallas, control_stock, pesopieza, espesor, usuario, coleccion, 
	color, uso, marcado, canto_vivo, referencia_laboratorio, version_laboratorio, modelo_origen, pieza_origen, prueba_origen, relieve, costilla, marco)
values	 	
	(:codigo_empresa, :destino, :descripcion_art, :v_fecha_alta, :v_familia, :v_marcas_codigo, :v_submarcas_codigo, :v_formato, :v_unidad, :v_sector, :v_tono, :v_calibre, :v_compras, :v_activo, 
	:v_prev_anular, :v_molde, 	:v_plato_sup, :v_plato_inf, :v_cliente, :referencia_lab, :v_control_stock, :v_pesopieza, :v_espesor, :v_usuario,
	:v_coleccion, :v_color, :v_uso,  :v_marcado, :v_canto_vivo, :referencia_lab, :version_lab, :modelo_origen, :pieza_origen, :prueba_origen, :relieve, :costilla, :marco);
				
if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de articulos "+ SQLCA.SQLErrText)
	bien = false
end if

insert into
	almartcal (empresa, articulo, calidad, fecha_alta)
values
	(:codigo_empresa, :destino, :v_calidad, :v_fecha_alta);

if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de almartcal "+ SQLCA.SQLErrText)
	bien = false
end if

insert into
	almartcajas (empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales, pordefecto)
values
	(:codigo_empresa, :destino, :v_caja, :v_piezascaja, :v_metroscaja, :v_metroslcaja, :v_pesocaja, :v_metros_reales, 'S');

if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Error en el insert de almartcaja "+ SQLCA.SQLErrText)
	bien = false
end if

insert into 
	palarticulo (empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
values
	(:codigo_empresa,  :destino, :v_codigopallet, :v_caja2, :v_cajaspallet, :v_planospallet, :v_alturas, 'S');

if SQLCA.SQLCode <> 0 then 
	MessageBox("Error", "Error en el insert de palarticulo "+ SQLCA.SQLErrText) 
	bien = false
end if

insert into
	art_codestadistico (empresa, codigo, g1, g2, g3, g4, pt, gd, nc, re, rectificado, av, pl, ct, en, otr, n, inkcid)
values 
	(:codigo_empresa, :destino, :v_g1, :v_g2, :v_g3, :v_g4, :v_pt, :v_gd, :v_nc, :v_re, :v_ee, :v_av, :v_pl, :v_ct, :v_en, :v_otr, :v_n, :v_inkcid);

if SQLCA.SQLCode <> 0 then 
	MessageBox("Error", "Error en el insert de art_codestadistico "+ SQLCA.SQLErrText) 
	bien = false
end if

insert into
	art_versiones ( empresa, articulo, version, base,  descripcion, observaciones, tipo_version)
values
	(:codigo_empresa, :destino, :v_version, :v_base, :v_descripcion_ver, :v_observaciones, :v_tipo_version);
	
if SQLCA.SQLCode <> 0 then 
	MessageBox("Error", "Error en el insert de art_versiones "+ SQLCA.SQLErrText) 
	bien = false
end if


////////////////////////////////
// Importar art_ver_operaciones
////////////////////////////////

delete 
from art_ver_operaciones
where empresa = :codigo_empresa
and articulo = :destino
and version = :v_version;

if SQLCA.SQLCode = -1 then exito = false

sel = " select articulo, operacion, tipo_operacion, orden, formato, factor, juegopantallas, numaplicaciones, coste, "+&
		" orientacion, piezas_fila "+&
		" from art_ver_operaciones "+&
		" where empresa = "+codigo_empresa+&
		" and articulo = "+origen+&
		" and version = 1"
		
f_cargar_cursor_nuevo (sel, operaciones)

for i = 1 to operaciones.RowCount() 
	v_operacion = operaciones.object.operacion[i]
	v_tipo_operacion = operaciones.object.tipo_operacion[i]
	v_orden= operaciones.object.orden[i]
	v_formato = operaciones.object.formato[i]
	v_factor = operaciones.object.factor[i]
	v_juegopantallas = operaciones.object.juegopantallas[i]
	v_numaplicaciones = operaciones.object.numaplicaciones[i]
	v_coste = operaciones.object.coste[i]
	v_orientacion = operaciones.object.orientacion[i]
	v_piezas_fila = operaciones.object.piezas_fila[i]
	insert into art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, 
												formato, factor, juegopantallas, numaplicaciones, coste, orientacion, piezas_fila) 
	values (:codigo_Empresa, :destino, '1', :v_operacion, :v_tipo_operacion, :v_orden, 
			:v_formato, :v_factor, :v_juegopantallas, :v_numaplicaciones, :v_coste, :v_orientacion, :v_piezas_fila);
	
	if SQLCA.SQLCode = -1 then exito = false	
	
	/////////////////////////////////////
	// Importar art_ver_op_aplicaciones
	/////////////////////////////////////
	
	sel = " select contadoraplicacion, pantalla, formula, gramaje, tipoaplicacion, orden, densidad, "+&
			" viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, gram_7x20, archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba "+&
			" from art_ver_op_aplicaciones "+&
			" where empresa = "+codigo_empresa+&
			" and articulo = "+origen+&
			" and version = 1 "+&
			" and operacion = "+v_operacion
			
	f_cargar_cursor_nuevo (sel, aplicaciones)
	
	delete from art_ver_op_aplicaciones
	where empresa = :codigo_empresa
	and articulo = :destino
	and version = "1"
	and operacion = :v_operacion;
	
	if SQLCA.SQLCode = -1 then exito = false

	for j = 1 to aplicaciones.rowcount()
		v_contadoraplicacion = aplicaciones.object.contadoraplicacion[j]
		v_pantalla = aplicaciones.object.pantalla[j]
		v_formula = aplicaciones.object.formula[j]
		v_gramaje = aplicaciones.object.gramaje[j]
		v_tipoaplicacion = aplicaciones.object.tipoaplicacion[j]
		v_ordenapl = aplicaciones.object.orden[j]
		v_densidad = aplicaciones.object.densidad[j]
		v_viscosidad = aplicaciones.object.viscosidad[j]
		v_boquilla = aplicaciones.object.boquilla[j]
		v_ciclo = aplicaciones.object.ciclo[j]
		v_temp_sup = aplicaciones.object.temp_sup[j]
		v_temp_inf = aplicaciones.object.temp_inf[j]
		v_cortes = aplicaciones.object.cortes[j]
		v_discos = aplicaciones.object.discos[j]
		v_paso_cliche = aplicaciones.object.paso_cliche[j]
		v_gram_7x20 = aplicaciones.object.gram_7x20[j]
		archivo_disenyo_tipomaquina_disenyo = aplicaciones.object.archivo_disenyo_tipomaquina_disenyo[j]
		archivo_disenyo_codigo = aplicaciones.object.archivo_disenyo_codigo[j]
		archivo_disenyo_prueba = aplicaciones.object.archivo_disenyo_prueba[j]
		if not isnull(archivo_disenyo_tipomaquina_disenyo) and archivo_disenyo_tipomaquina_disenyo = '3' then
			//Se copia, solo en caso de serigrafía
		else
			//Se pone a null
			setnull(archivo_disenyo_tipomaquina_disenyo)
			setnull(archivo_disenyo_codigo)
			setnull(archivo_disenyo_prueba)
		end if
		
		insert into art_ver_op_aplicaciones
		(empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, tipoaplicacion, 
		orden, densidad, viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, gram_7x20,
		archivo_disenyo_tipomaquina_disenyo, archivo_disenyo_codigo, archivo_disenyo_prueba)
		values (:codigo_empresa, :destino, "1", :v_operacion, :v_contadoraplicacion, :v_pantalla, :v_formula, :v_gramaje, :v_tipoaplicacion,
		:v_ordenapl, :v_densidad, :v_viscosidad, :v_boquilla, :v_ciclo, :v_temp_sup, :v_temp_inf, :v_cortes, :v_discos, :v_paso_cliche, :v_gram_7x20, 
		:archivo_disenyo_tipomaquina_disenyo, :archivo_disenyo_codigo, :archivo_disenyo_prueba);
		
		if SQLCA.SQLCode = -1 then exito = false	
	next
	f_mensaje_proceso ("Operación", i, operaciones.rowcount())
	
next
//////////////////////////////////////////////////////////////
//				FIN DE IMPORTAR OPERACIONES							//
//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
// Cálculo del coste de MP todas las operaciones 
//////////////////////////////////////////////////////////////

sel = " select articulo, version, operacion "+&
		" from art_ver_operaciones "+&
		" where articulo = '"+destino+"' "+&
		" and version = '1' "
f_cargar_cursor_nuevo (sel, regs_coste)

for m = 1 to regs_coste.rowcount()
	operacion = regs_coste.object.operacion[m]
	ver = regs_coste.object.version[m]
	select sum (coste_kg_formula * art_ver_op_aplicaciones.gramaje / 1000 ) 
	into :coste_mp_operacion
	from art_ver_op_aplicaciones, prodformula
	where art_ver_op_aplicaciones.empresa = :codigo_empresa
	and art_ver_op_aplicaciones.formula = prodformula.formula
	and art_ver_op_aplicaciones.articulo = :destino
	and art_ver_op_aplicaciones.operacion = :operacion
	and art_ver_op_aplicaciones.version = :ver;
	
	update art_ver_operaciones
	set coste_mp = :coste_mp_operacion 
	where empresa = :codigo_empresa
	and articulo = :destino
	and version = :ver
	and operacion = :operacion;
	
	if SQLCA.SQLCode = -1 then exito = false	
next

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

		
if bien then
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox ("Error", "No se pudo duplicar el artículo")
end if
return true
destroy operaciones

end function

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
cb_eliminar3.enabled = false
cb_añadir3.enabled = false

end event

event open;call super::open;integer permiso

permiso = f_permiso_usuario( string(this.classname()), nombre_usuario)

choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Altas de Artículos"

This.title = istr_parametros.s_titulo_ventana

dw_codestadistico.SetTransObject(SQLCA)
dw_observacion_version.SetTransObject(SQLCA)
dw_escandallo.SetTransObject(SQLCA)
dw_versiones.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_codestadistico.Retrieve(codigo_empresa,sle_valor.Text)
		dw_observacion_version.Retrieve(codigo_empresa,sle_valor.Text, '1')
		dw_escandallo.Retrieve(codigo_empresa,sle_valor.Text, '1')
		dw_versiones.Retrieve(codigo_empresa,sle_valor.Text, '1')
	END IF
END IF

	
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
cb_eliminar3.enabled = true
cb_añadir3.enabled = true


end event

event ue_inserta_fila;call super::ue_inserta_fila;long fila

dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

fila = dw_codestadistico.insertrow(0)
dw_codestadistico.setitem(fila, "empresa", codigo_empresa)
dw_codestadistico.setitem(fila, "codigo", sle_valor.text)

fila = dw_observacion_version.insertrow(0)
dw_observacion_version.setitem(fila, "empresa", codigo_empresa)
dw_observacion_version.setitem(fila, "articulo", sle_valor.text)
dw_observacion_version.setitem(fila, "version", '1')

fila = dw_versiones.insertrow(0)
dw_versiones.setitem(fila, "empresa", codigo_empresa)
dw_versiones.setitem(fila, "articulo", sle_valor.text)
dw_versiones.setitem(fila, "version", '1')


end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "articulos"


///////////////////////////////////////////////////////
// 	CONTROL STOCK, PEDIDO Y PLANIFICADO
///////////////////////////////////////////////////////

boolean hay_pedido, hay_stock, hay_planificado
int total
string texto
String articulo, ruta

hay_pedido = false
hay_stock = false
hay_planificado = false
texto = ""
total = 0

if sle_valor.text <> '' and not isnull (sle_valor.text) then
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
	
	if texto <> '' then
		messagebox("Aviso", nombre_usuario+": "+texto)
	end if 
end if

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_codestadistico.Retrieve(codigo_empresa,sle_valor.Text)
dw_observacion_version.Retrieve(codigo_empresa,sle_valor.Text, '1')
dw_escandallo.Retrieve(codigo_empresa,sle_valor.Text, '1')
dw_versiones.Retrieve(codigo_empresa,sle_valor.Text, '1')


if dw_1.RowCount() > 0 then
	articulo = String(sle_valor.text)
	ruta = ftc_imagen_articulo_ruta("3", articulo)
	if ruta <> "" then
		p_imagen.visible = false
		dw_imagen.Object.datawindow.picture.File =  ruta
	else
		p_imagen.PictureName = f_cargar_imagen_nuevo(dw_1.object.articulos_codigo_pantallas[dw_1.Getrow()])
		dw_imagen.visible = false
	end if
end if

CALL Super::ue_recuperar
end event

on w_mant_altas_laboratorio.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_codestadistico=create dw_codestadistico
this.dw_observacion_version=create dw_observacion_version
this.dw_calidad_altas=create dw_calidad_altas
this.cb_3=create cb_3
this.dw_listado_ficha=create dw_listado_ficha
this.dw_2=create dw_2
this.dw_3=create dw_3
this.pb_4=create pb_4
this.cb_5=create cb_5
this.st_4=create st_4
this.uo_articulo=create uo_articulo
this.pb_duplicar=create pb_duplicar
this.dw_versiones=create dw_versiones
this.st_2=create st_2
this.st_50=create st_50
this.dw_escandallo=create dw_escandallo
this.cb_añadir3=create cb_añadir3
this.cb_eliminar3=create cb_eliminar3
this.r_4=create r_4
this.r_3=create r_3
this.p_imagen=create p_imagen
this.pb_desbloquear=create pb_desbloquear
this.pb_1=create pb_1
this.pb_importar=create pb_importar
this.st_mensaje=create st_mensaje
this.cb_2=create cb_2
this.r_1=create r_1
this.dw_imagen=create dw_imagen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_codestadistico
this.Control[iCurrent+3]=this.dw_observacion_version
this.Control[iCurrent+4]=this.dw_calidad_altas
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_listado_ficha
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.pb_4
this.Control[iCurrent+10]=this.cb_5
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.uo_articulo
this.Control[iCurrent+13]=this.pb_duplicar
this.Control[iCurrent+14]=this.dw_versiones
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_50
this.Control[iCurrent+17]=this.dw_escandallo
this.Control[iCurrent+18]=this.cb_añadir3
this.Control[iCurrent+19]=this.cb_eliminar3
this.Control[iCurrent+20]=this.r_4
this.Control[iCurrent+21]=this.r_3
this.Control[iCurrent+22]=this.p_imagen
this.Control[iCurrent+23]=this.pb_desbloquear
this.Control[iCurrent+24]=this.pb_1
this.Control[iCurrent+25]=this.pb_importar
this.Control[iCurrent+26]=this.st_mensaje
this.Control[iCurrent+27]=this.cb_2
this.Control[iCurrent+28]=this.r_1
this.Control[iCurrent+29]=this.dw_imagen
end on

on w_mant_altas_laboratorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_codestadistico)
destroy(this.dw_observacion_version)
destroy(this.dw_calidad_altas)
destroy(this.cb_3)
destroy(this.dw_listado_ficha)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.pb_4)
destroy(this.cb_5)
destroy(this.st_4)
destroy(this.uo_articulo)
destroy(this.pb_duplicar)
destroy(this.dw_versiones)
destroy(this.st_2)
destroy(this.st_50)
destroy(this.dw_escandallo)
destroy(this.cb_añadir3)
destroy(this.cb_eliminar3)
destroy(this.r_4)
destroy(this.r_3)
destroy(this.p_imagen)
destroy(this.pb_desbloquear)
destroy(this.pb_1)
destroy(this.pb_importar)
destroy(this.st_mensaje)
destroy(this.cb_2)
destroy(this.r_1)
destroy(this.dw_imagen)
end on

event closequery;call super::closequery;int total
integer li_rc 
string motivo, controles, campo
long numero, i
datawindow dato
boolean falta_campo

IF dw_1.DeletedCount()+dw_1.ModifiedCount() + &
	dw_codestadistico.DeletedCount() + dw_codestadistico.ModifiedCount() + &
	dw_observacion_version.DeletedCount() + dw_observacion_version.ModifiedCount()  > 0 THEN
	li_rc = MessageBox("Pregunta", "¿Guardar Cambios?", Question!, YesNoCancel!, 3)
	//User chose to up data and close window
	IF li_rc = 1 THEN
//		cb_grabar.TriggerEvent(Clicked!)	
//		cb_grabar2.TriggerEvent(Clicked!)	
//		cb_grabarh.TriggerEvent(Clicked!)	
	
		RETURN 0
	//User chose to close window without updating
	ELSEIF li_rc = 2 THEN
		RETURN 0
	//User canceled
	ELSE
		RETURN 1
	END IF
ELSE
	// No changes to the data, window will just close
	RETURN 0
END IF


end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_altas_laboratorio
integer x = 32
integer y = 316
integer width = 1993
integer height = 948
integer taborder = 20
string dataobject = "dw_mant_altas_laboratorio"
end type

event dw_1::rbuttondown;string cliente
str_wt_busquedas_salida resultado

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "AYUDA SELECCION DE MOLDES"
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro     = "activo = 'S'"
CASE "articulos_marco"
	bus_titulo     = "AYUDA SELECCION DE MARCOS"
	bus_datawindow = "dw_ayuda_prodmarcos"
	bus_filtro     = "activo = 'S' and molde = '" +string(this.object.molde[this.GetRow()])+"' "
CASE "articulos_costilla"
	bus_titulo     = "VENTANA SELECCION COSTILLA "
	bus_datawindow = "dw_ayuda_costilla"
	
CASE "plato_sup"
	bus_titulo     = "VENTANA SELECCION DE PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "activo = 'S' and molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Superior'"
CASE "plato_inf"
	bus_titulo     = "AYUDA SELECCION PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "activo = 'S' and molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Inferior'"
CASE "articulos_etiqueta_ce"
	bus_titulo     = "AYUDA SELECCION TIPOS DE MARCADO"
	bus_datawindow = "dw_ayuda_tipo_etiqueta_ce"
	select cliente
	into :cliente
	from articulos
	where empresa = :codigo_empresa
	and codigo = :sle_valor.text;
	if cliente <> '' or not isnull(cliente) then
		bus_filtro     = "cliente = '" +cliente+"'"
	end if
CASE "articulos_relieve"
//	bus_titulo     = "AYUDA SELECCION DE RELIEVE"
//	bus_datawindow = "dw_ayuda_art_tipomoldura"
//	bus_filtro     = ""
	Open(wtc_ayuda_busqueda_relieves)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado >= 2 then
		this.object.articulos_relieve[this.getrow()] = resultado.valores[1]
		this.object.art_tipomoldura_descripcion[this.getrow()] = resultado.valores[2]
	end if
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::key;string cliente
str_wt_busquedas_salida resultado

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "AYUDA SELECCION DE MOLDES"
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro     = "activo = 'S'"
CASE "articulos_marco"
	bus_titulo     = "AYUDA SELECCION DE MARCOS"
	bus_datawindow = "dw_ayuda_prodmarcos"
	bus_filtro     = "activo = 'S' and molde = '" +string(this.object.molde[this.GetRow()])+"' "
CASE "articulos_costilla"
	bus_titulo     = "VENTANA SELECCION COSTILLA "
	bus_datawindow = "dw_ayuda_costilla"
	
CASE "plato_sup"
	bus_titulo     = "VENTANA SELECCION DE PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "activo = 'S' and  molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Superior'"
CASE "plato_inf"
	bus_titulo     = "AYUDA SELECCION PLATOS"
	bus_datawindow = "dw_ayuda_prodplatos"
	bus_filtro     = "activo = 'S' and molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Inferior'"
CASE "articulos_etiqueta_ce"
	bus_titulo     = "AYUDA SELECCION TIPOS DE MARCADO"
	bus_datawindow = "dw_ayuda_tipo_etiqueta_ce"
	select cliente
	into :cliente
	from articulos
	where empresa = :codigo_empresa
	and codigo = :sle_valor.text;
	if cliente <> '' or not isnull(cliente) then
		bus_filtro     = "cliente = '"+cliente+"'"
	end if
CASE "articulos_relieve"
	//bus_titulo     = "AYUDA SELECCION DE RELIEVE"
	//bus_datawindow = "dw_ayuda_art_tipomoldura"
	//bus_filtro     = ""
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
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key
end event

event dw_1::itemchanged;call super::itemchanged;string v_juegopantallas, v_factormp, operacion, cliente

IF dwo.Name = "molde" THEN
	dw_1.object.prodmoldes_descripcion[row] = f_nombre_molde(codigo_empresa, data)
END IF
IF dwo.Name = "articulos_marco" THEN
	dw_1.object.prodmarcos_descripcion[row] = f_nombre_marco(codigo_empresa, data)
END IF
IF dwo.Name = "plato_sup" THEN
	dw_1.object.prodplatos_descripcion[row] = f_nombre_plato(codigo_empresa, data)
END IF
IF dwo.Name = "plato_inf" THEN
	dw_1.object.prodplatos_Descripcion_1[row] = f_nombre_plato(codigo_empresa,data)
END IF
IF dwo.Name = "articulos_etiqueta_ce" THEN
	select cliente 
	into :cliente
	from articulos
	where empresa = :codigo_empresa
	and codigo = :sle_valor.text;
	if cliente <> '' or not isnull(cliente) then
		dw_1.object.ce_marcado_descripcion[row] = f_nombre_etiqueta_ce(codigo_empresa, cliente, data)
	end if

END IF
IF dwo.Name = "articulos_relieve" THEN
	dw_1.object.art_tipomoldura_descripcion[row] = f_nombre_tipomoldura2(codigo_empresa, data)
END IF


end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_altas_laboratorio
integer x = 32
integer y = 188
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_altas_laboratorio
integer x = 1541
integer y = 184
integer width = 238
integer height = 96
end type

event cb_insertar::clicked;
int total
integer li_rc 
string motivo, controles, campo
long numero, i, j, k, l, total_regs
datawindow dato
boolean falta_campo, exito
string v_g2, v_g3, v_formato, v_uso

select g2, g3
into :v_g2, :v_g3
from art_codestadistico
where empresa = :codigo_empresa
and codigo = :sle_valor.text;
if isnull(v_g2) then v_g2 = ''
if isnull(v_g3) then v_g3 = ''

select formato, uso
into :v_formato, :v_uso
from articulos 
where codigo = :sle_valor.text
and empresa = :codigo_empresa;
if isnull(v_formato ) then v_formato = ''

if v_formato <> '' and v_g2 <> '' and v_g3 <> '' then
	f_valorar_stock()
else
	messagebox("Aviso", " No se ha podido valorar el stock.")
end if	

IF dw_1.rowcount() > 0 THEN
	falta_campo = false
	
	dw_1.accepttext()
	i = dw_1.getrow()
	dw_codestadistico.accepttext()
	j = dw_codestadistico.getrow()
	
	// DW_1
	IF IsNull(dw_1.object.pesopieza[i]) or Trim(String(dw_1.object.pesopieza[i]))="" or dw_1.object.pesopieza[i] = 0 THEN
		  campo="pesopieza"
		  motivo  = "(Campo Obligatorio) Introduzca el peso."
		  dato = dw_1
		  numero = 1
		  falta_campo = True
	ELSEIF IsNull(dw_1.object.molde[i]) or Trim(String(dw_1.object.molde[i]))="" THEN
		  campo="molde"
		  motivo  = "(Campo Obligatorio) Introduzca el molde."
		  dato = dw_1
		  numero = 1
		  falta_campo = True

	END IF

// No quiero que se hagan los calculos de pesos y metros en este mantenimiento
//	f_calculos_caja()
		
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dato.setfocus()
	  dato.SetColumn(campo)
	  return 1
	END IF
END IF
exito = true
connect using SQLCA;
if dw_versiones.rowcount() = 0 then
	dw_versiones.Insertrow(0)
end if
if dw_versiones.rowcount() > 0 then 
	select count(*)
	into :total_regs
	from art_ver_operaciones
	where empresa = :codigo_empresa
	and articulo = :sle_valor.text
	and version = '1';
	
	exito = true
	if total_regs = 0 then
		delete from art_ver_operaciones
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text;
		if SQLCA.SQLCode = -1 then
			exito = false
			messagebox("Error", "No se ha podido Grabando (1)")
		END IF

		delete from art_ver_op_aplicaciones
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text;
		if SQLCA.SQLCode = -1 then
			exito = false
			messagebox("Error", "No se ha podido Grabando (2)")
		END IF
		
		v_formato = dw_1.object.articulos_formato[dw_1.getrow()]
		if v_uso = '3' then
			insert into art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, formato, factor, coste)
			values (:codigo_empresa, :sle_valor.text, '1', '1', '9',1,:v_formato,1,'1' );
			if SQLCA.SQLCode = -1 then
				exito = false
				messagebox("Error", "No se ha podido Grabando (3)")
			END IF
			
			insert into art_ver_op_aplicaciones (empresa, articulo, version, operacion, contadoraplicacion, tipoaplicacion, orden )
			values (:codigo_empresa, :sle_valor.text, '1', '1', '1','19', '1');
			if SQLCA.SQLCode = -1 then
				exito = false
				messagebox("Error", "No se ha podido Grabando (4)")
			END IF
		end if
	end if
end if

if exito then
	dw_codestadistico.update() 
	dw_observacion_version.update() 
	dw_versiones.update() 
	if SQLCA.SQLCode = -1 then
		exito = false
		messagebox("Error", "No se ha podido Grabando (5)")
	END IF
end if

if exito then
	commit using SQLCA;
else
	rollback using SQLCA;
	return;
	messagebox("Error", "Error al Grabar")
end if
Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_altas_laboratorio
integer x = 1774
integer y = 184
integer width = 251
integer height = 96
end type

event cb_borrar::clicked;string valor
boolean exito

valor = sle_valor.text
//if MessageBox("Aviso", "¿Se Borraran todas las Pantallas Asociadas?", Exclamation!, YesNo!, 2) = 1 then

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
		and articulo = :valor;
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
					and articulo = :valor
					and version = '1';
					if SQLCA.SQLCode <> 0 then
						exito = false
					else
						delete from almartcal
						where empresa = :codigo_empresa 
						and articulo = :valor;
						if SQLCA.SQLCode <> 0 then
							exito = false
						end if
					end if
				end if
			end if
	
		end if
	end if
	
	if exito then
		commit;
	else
		rollback;
	end if
end if
//end if



end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_altas_laboratorio
integer x = 293
integer y = 184
integer width = 293
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_articulos"
ue_titulo      = "AYUDA SELECCION DE ARTÍCULOS"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_altas_laboratorio
integer x = 2021
integer y = 184
integer width = 238
integer height = 96
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_altas_laboratorio
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_altas_laboratorio
integer y = 184
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_altas_laboratorio
integer y = 16
integer width = 3589
end type

type pb_calculadora from u_calculadora within w_mant_altas_laboratorio
integer x = 599
integer y = 176
integer taborder = 0
end type

event clicked;Integer registros

IF cb_insertar.enabled=TRUE THEN Return

Select count(*) 
Into :registros 
From articulos
where empresa = :codigo_empresa;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,codigo)+1) 
   Into   :registros
   From   articulos
	where empresa = :codigo_empresa;
	sle_valor.text=string(registros)
END IF

dw_1.triggerEvent("clicked")

end event

type dw_codestadistico from u_datawindow within w_mant_altas_laboratorio
integer x = 2057
integer y = 304
integer width = 1541
integer height = 716
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_codestadistico_alta_laboratorio"
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
IF dwo.Name = "art_codestadistico_g4" THEN
	dw_codestadistico.object.art_grupo4_descripcion[row] = f_nombre_grupo4(codigo_empresa, data)
END IF
IF dwo.Name = "art_codestadistico_ct" THEN
	dw_codestadistico.object.art_cortes_descripcion[row] = f_nombre_cortes(codigo_empresa, data)
END IF
IF dwo.Name = "art_codestadistico_tm" THEN
	dw_codestadistico.object.art_tipomoldura_descripcion[row] = f_nombre_tipomoldura(codigo_empresa, data)
END IF

end event

event rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "art_codestadistico_g4"
	bus_titulo     = "AYUDA SELECCION DE G4"
	bus_datawindow = "dw_ayuda_art_grupo4_abr"
	bus_filtro     = ""
CASE "art_codestadistico_ct"
	bus_titulo     = "AYUDA SELECCION DE CORTES"
	bus_datawindow = "dw_ayuda_art_cortes_abr"
	bus_filtro     = ""
CASE "art_codestadistico_tm"
	bus_titulo     = "AYUDA SELECCION DE CORTES"
	bus_datawindow = "dw_ayuda_art_tipomoldura_abr"
	bus_filtro     = ""

CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "art_codestadistico_g4"
	bus_titulo     = "AYUDA SELECCION DE G4"
	bus_datawindow = "dw_ayuda_art_grupo4_abr"
	bus_filtro     = ""
CASE "art_codestadistico_ct"
	bus_titulo     = "AYUDA SELECCION DE CORTES"
	bus_datawindow = "dw_ayuda_art_cortes_abr"
	bus_filtro     = ""
CASE "art_codestadistico_tm"
	bus_titulo     = "AYUDA SELECCION DE CORTES"
	bus_datawindow = "dw_ayuda_art_tipomoldura_abr"
	bus_filtro     = ""

CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_observacion_version from u_datawindow within w_mant_altas_laboratorio
integer x = 32
integer y = 1944
integer width = 1993
integer height = 580
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_observacion_version"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if




end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_calidad_altas from u_datawindow within w_mant_altas_laboratorio
boolean visible = false
integer x = 169
integer y = 2784
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

type cb_3 from commandbutton within w_mant_altas_laboratorio
boolean visible = false
integer x = 2546
integer y = 1772
integer width = 658
integer height = 112
integer taborder = 110
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

type dw_listado_ficha from datawindow within w_mant_altas_laboratorio
boolean visible = false
integer x = 2912
integer y = 920
integer width = 311
integer height = 180
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_mant_altas_laboratorio
boolean visible = false
integer x = 2194
integer y = 1872
integer width = 311
integer height = 180
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_mant_altas_laboratorio
boolean visible = false
integer x = 3246
integer y = 1696
integer width = 311
integer height = 180
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_4 from upb_imprimir within w_mant_altas_laboratorio
integer x = 1175
integer y = 188
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type

event clicked;string escandallo[],version_esc[],camino
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

end event

type cb_5 from commandbutton within w_mant_altas_laboratorio
integer x = 736
integer y = 188
integer width = 439
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ficha Técnica"
end type

event clicked;if sle_valor.text <> "" then
	if not isnull(sle_valor.text) then
		str_parametros lstr_param
		lstr_param.s_argumentos[2] = sle_valor.text
		lstr_param.i_nargumentos = 2
//		OpenWithParm(w_mant_versiones_tencer, lstr_param)
		OpenWithParm(w_mant_altas_intermedios_nuevo, lstr_param)
	end if
end if
end event

type st_4 from statictext within w_mant_altas_laboratorio
integer x = 2272
integer y = 200
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 65535
string text = "Artículo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_articulo from u_em_campo_2 within w_mant_altas_laboratorio
event destroy ( )
integer x = 2519
integer y = 180
integer width = 846
integer height = 88
integer taborder = 50
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type pb_duplicar from picturebutton within w_mant_altas_laboratorio
integer x = 3374
integer y = 180
integer width = 101
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "Import5!"
alignment htextalign = left!
string powertiptext = "Importar artículo"
end type

event clicked;decimal v_pesopieza, v_espesor
string v_molde, v_plato_sup, v_plato_inf
boolean exito
string v_g4, v_nc, v_rectificado, v_av, v_pl, v_ct, v_tm, v_n, v_inkcid
string v_articulo, v_etiqueta_ce, formato, des_version, v_tipo_version
string marco, costilla

if uo_articulo.em_codigo.text <> '' then
	dw_1.TriggerEvent(Clicked!)
	
	v_articulo = uo_articulo.em_codigo.text
	
	select pesopieza, molde, plato_sup, plato_inf, etiqueta_ce, relieve, espesor, marco, costilla
	into :v_pesopieza, :v_molde, :v_plato_sup, :v_plato_inf, :v_etiqueta_ce, :v_tm, :v_espesor, :marco, :costilla
	from articulos
	where empresa = :codigo_empresa
	and codigo = :v_articulo;
	
	dw_1.object.pesopieza[dw_1.getrow()] = v_pesopieza
	dw_1.object.molde[dw_1.getrow()] = v_molde
	dw_1.object.articulos_marco[dw_1.getrow()] = marco
	dw_1.object.articulos_costilla[dw_1.getrow()] = costilla
	dw_1.object.plato_sup[dw_1.getrow()] = v_plato_sup
	dw_1.object.plato_inf[dw_1.getrow()] = v_plato_inf
	dw_1.object.articulos_etiqueta_ce[dw_1.getrow()] = v_etiqueta_ce
	dw_1.object.articulos_relieve[dw_1.getrow()] = v_tm
	dw_1.object.articulos_espesor[dw_1.getrow()] = v_espesor
	
	select g4, nc, rectificado, av, pl, ct, n, inkcid
	into :v_g4, :v_nc, :v_rectificado, :v_av, :v_pl, :v_ct, :v_n, :v_inkcid
	from art_codestadistico
	where empresa = :codigo_empresa
	and codigo = :v_articulo;
	
	dw_codestadistico.object.art_codestadistico_g4[dw_codestadistico.getrow()] = v_g4
	dw_codestadistico.object.art_codestadistico_nc[dw_codestadistico.getrow()] = v_nc
	dw_codestadistico.object.art_codestadistico_rectificado[dw_codestadistico.getrow()] = v_rectificado
	dw_codestadistico.object.art_codestadistico_av[dw_codestadistico.getrow()] = v_av
	dw_codestadistico.object.art_codestadistico_pl[dw_codestadistico.getrow()] = v_pl
	dw_codestadistico.object.art_codestadistico_ct[dw_codestadistico.getrow()] = v_ct
	dw_codestadistico.object.art_codestadistico_n[dw_codestadistico.getrow()] = v_n
	dw_codestadistico.object.art_codestadistico_inkcid[dw_codestadistico.getrow()] = v_inkcid
	
	select descripcion, tipo_version
	into :des_version, :v_tipo_version
	from art_versiones
	where empresa = :codigo_empresa
	and articulo = :v_articulo
	and version = '1';
	
	if dw_versiones.rowcount() = 0 then
		dw_versiones.insertrow(0)
	end if
	dw_versiones.object.empresa[dw_versiones.getrow()] = codigo_empresa
	dw_versiones.object.articulo[dw_versiones.getrow()] = sle_valor.text
	dw_versiones.object.version[dw_versiones.getrow()] = '1'
	dw_versiones.object.descripcion[dw_versiones.getrow()] = des_version
	dw_versiones.object.tipo_version[dw_versiones.getrow()] = v_tipo_version
else
	messagebox ("Atención", "Debe introducir el artículo origen")
end if
end event

type dw_versiones from u_datawindow within w_mant_altas_laboratorio
integer x = 178
integer y = 1480
integer width = 1719
integer height = 296
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_versiones_tencer"
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
end if
//
//If row=0 Then Return
//IF ue_marca_linea = TRUE Then
//  this.SetRow(row)
//END IF



end event

event itemchanged;
IF dwo.Name = "base" THEN
	this.object.base[row] = f_nombre_articulo(codigo_empresa, data)
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
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
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

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type st_2 from statictext within w_mant_altas_laboratorio
integer x = 178
integer y = 1308
integer width = 1719
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
string text = "Versión 1"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_50 from statictext within w_mant_altas_laboratorio
integer x = 2075
integer y = 1348
integer width = 1527
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217729
boolean enabled = false
string text = "Escandallo"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_escandallo from u_datawindow within w_mant_altas_laboratorio
integer x = 2075
integer y = 1420
integer width = 1527
integer height = 424
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_escandallo"
boolean vscrollbar = true
end type

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_1.triggerevent(clicked!)
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

type cb_añadir3 from commandbutton within w_mant_altas_laboratorio
integer x = 2094
integer y = 1856
integer width = 731
integer height = 68
integer taborder = 70
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


dw_escandallo.scrolltorow(dw_escandallo.InsertRow(0))
dw_escandallo.SetColumn(1)

fila_actual = dw_escandallo.Getrow()
total_filas = dw_escandallo.RowCount()

dw_escandallo.object.art_escandallo_empresa[fila_actual] = codigo_empresa
dw_escandallo.object.art_escandallo_articulo[fila_actual] = sle_valor.text
dw_escandallo.object.art_escandallo_version[fila_actual] = '1'


end event

type cb_eliminar3 from commandbutton within w_mant_altas_laboratorio
integer x = 2830
integer y = 1856
integer width = 731
integer height = 68
integer taborder = 70
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

type r_4 from rectangle within w_mant_altas_laboratorio
integer linethickness = 4
long fillcolor = 65535
integer x = 2263
integer y = 172
integer width = 1330
integer height = 108
end type

type r_3 from rectangle within w_mant_altas_laboratorio
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 134217729
integer x = 46
integer y = 2144
integer width = 1495
integer height = 88
end type

type p_imagen from picture within w_mant_altas_laboratorio
integer x = 2085
integer y = 1944
integer width = 1509
integer height = 576
boolean originalsize = true
boolean focusrectangle = false
end type

type pb_desbloquear from picturebutton within w_mant_altas_laboratorio
integer x = 1298
integer y = 196
integer width = 110
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Custom016!"
alignment htextalign = left!
end type

event clicked;//w_mant_altas_laboratorio 
int total_Regs 
dec coste_packing 

if dw_1.object.articulos_bloqueado[dw_1.getrow()] = 'S' then
	dw_1.setitem(dw_1.getrow(),"articulos_bloqueado",'N')
	if sle_valor.text <> '' then
		update articulos
		set bloqueado = 'N'
		where empresa = :codigo_empresa
		and codigo = :sle_valor.text using sqlca;
		
		commit using SQLCA;
	end if
else
	dw_1.setitem(dw_1.getrow(),"articulos_bloqueado",'S')
	if sle_valor.text <> '' then
		update articulos
		set bloqueado = 'S'
		where empresa = :codigo_empresa
		and codigo = :sle_valor.text using sqlca;
		
		commit using SQLCA;
	end if
	// Calculo del coste de las cajas
	if dw_1.object.articulos_uso[dw_1.GetRow()] = '3' then
		select count (*) into :total_Regs from  art_ver_operaciones where articulo = :sle_valor.text and empresa = :codigo_empresa;
		
		if total_Regs > 0 then
//			dw_operaciones.object.art_ver_operaciones_coste_packing[dw_operaciones.GetRow()] = f_calculo_coste_packing (codigo_empresa, sle_valor.text)
			coste_packing = f_calculo_coste_packing (codigo_empresa, sle_valor.text)
			
			update art_ver_operaciones
			set coste_packing = :coste_packing
			where empresa = :codigo_empresa
			and articulo = :sle_valor.text using sqlca;
		end if
	end if
	
	commit using SQLCA;
end if
	

//parent.triggerevent("ue_recuperar")
end event

type pb_1 from picturebutton within w_mant_altas_laboratorio
boolean visible = false
integer x = 1403
integer y = 188
integer width = 110
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "Custom048!"
alignment htextalign = left!
string powertiptext = "Clacular Coste"
end type

event clicked;string  articulo, escenario
dec coste
Datetime fecha_calculo
boolean hay_error

fecha_calculo = datetime(today())
select codigo
into :escenario 
from coste_escenario
where empresa = :codigo_empresa
and predet = 'S';

articulo = sle_valor.text

coste = f_calculo_coste_articulo ( codigo_empresa, articulo)

delete from coste_articulo_hist 
where empresa = :codigo_empresa 
and fecha_calc = :fecha_calculo
and escenario = :escenario using SQLCA;

if SQLCA.Sqlcode = -1 then
	hay_error = true
end if

insert into coste_articulo_hist (empresa, articulo, fecha_calc, coste, escenario )
		 values (:codigo_empresa, :articulo, :fecha_calculo, :coste, 'escenario') using sqlca;

if SQLCA.Sqlcode = -1 then
	hay_error = true
end if
		 
if hay_error then
	messagebox ("Error", "Se produjo un error y no se cálculo el coste .")
	rollback using SQLCA;
else
	commit using SQLCA;
end if
	



end event

type pb_importar from picturebutton within w_mant_altas_laboratorio
integer x = 3479
integer y = 180
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "SetDefaultClass!"
string powertiptext = "Importar estructura completa y cabecera."
end type

event clicked;string padre, padre_c, referencia_laboratorio, codigo_pantallas, descripcion_Art
integer version_laboratorio
str_escandallo escandallo[300]
integer nivel, indice
dec factor

if uo_articulo.em_codigo.text <> '' then
	st_mensaje.visible = true
	f_escandallo_factores(escandallo, uo_articulo.em_codigo.text, indice, factor, nivel)
	st_mensaje.visible = false

	if escandallo[300].articulo = "CORRECTO" then
		pb_duplicar.TriggerEvent(clicked!)
		cb_insertar.TriggerEvent(clicked!)
			
		if MessageBox("Pregunta", "Ahora se generará una estructura completa identica a la de ~r"+&
							uo_articulo.em_codigo.text+": "+uo_articulo.em_campo.text+".~r¿Desea Continuar?",   Exclamation!, YesNo!, 2) = 1 then
							
			connect using SQLCA;				
			padre = uo_articulo.em_codigo.text
			padre_c = sle_valor.text
			descripcion_Art = dw_1.object.descripcion[dw_1.getrow()]
			referencia_laboratorio = dw_1.object.articulos_referencia_laboratorio[dw_1.getrow()]
			version_laboratorio = dw_1.object.articulos_version_laboratorio[dw_1.getrow()]
			codigo_pantallas = dw_1.object.articulos_codigo_pantallas[dw_1.getrow()]
	
				if f_duplicar_estructura (padre, padre_c, descripcion_Art, referencia_laboratorio, version_laboratorio, codigo_pantallas) then
					commit;
					messagebox ("Atención", "La estructura se ha duplicado")
				else 
					rollback;
					messagebox ("Error", "Se ha producido un error al duplicar la estructura")
				end if
		end if
	else
		messagebox ("Error", "Desbordamiento en la estructura del artículo "+uo_articulo.em_codigo.text+"    ")
	end if
else
	messagebox ("Atención", "Debe introducir el artículo origen")
end if

end event

type st_mensaje from statictext within w_mant_altas_laboratorio
boolean visible = false
integer x = 14
integer width = 3593
integer height = 108
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 255
string text = "Comprobando errores en la estructura origen"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_mant_altas_laboratorio
boolean visible = false
integer x = 2277
integer y = 2088
integer width = 1070
integer height = 112
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recálculo Coste MP"
end type

event clicked;string articulo, operacion, ver, sel
dec coste_mp_operacion
datastore regs_coste
long m
boolean exito

sel = " select articulo, version, operacion "+&
		" from art_ver_operaciones "

		
f_cargar_cursor_nuevo (sel, regs_coste)
connect using SQLCA;
exito = true
for m = 1 to regs_coste.rowcount()
	articulo = regs_coste.object.articulo[m]
	operacion = regs_coste.object.operacion[m]
	ver = regs_coste.object.version[m]
	select sum (coste_kg_formula * art_ver_op_aplicaciones.gramaje / 1000 ) 
	into :coste_mp_operacion
	from art_ver_op_aplicaciones, prodformula
	where art_ver_op_aplicaciones.empresa = :codigo_empresa
	and art_ver_op_aplicaciones.formula = prodformula.formula
	and art_ver_op_aplicaciones.articulo = :articulo
	and art_ver_op_aplicaciones.operacion = :operacion
	and art_ver_op_aplicaciones.version = :ver;
	
	update art_ver_operaciones
	set coste_mp = :coste_mp_operacion 
	where empresa = :codigo_empresa
	and articulo = :articulo
	and version = :ver
	and operacion = :operacion;
	
	if SQLCA.SQLCode = -1 then exito = false	
	f_mensaje_proceso ("", m,regs_coste.rowcount()) 
next

if exito then
	commit using SQLCA;
	messagebox ("OK","OK")
else
	rollback using SQLCA;
	messagebox ("error","error")	
end if
end event

type r_1 from rectangle within w_mant_altas_laboratorio
integer linethickness = 4
long fillcolor = 12632256
integer x = 46
integer y = 1356
integer width = 1993
integer height = 568
end type

type dw_imagen from u_dw_imagen within w_mant_altas_laboratorio
integer x = 2080
integer y = 1944
integer width = 1513
integer height = 580
integer taborder = 140
end type

