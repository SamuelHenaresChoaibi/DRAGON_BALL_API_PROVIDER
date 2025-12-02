import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//Pantalla de detalle de cualquier objeto de Elden Ring (arma, armadura, hechizo, espíritu, talismán…)
class EldenDetailsScreen extends StatelessWidget {
  const EldenDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Recoge los argumentos enviados desde la pantalla anterior
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final dynamic item = args['item']; //Objeto concreto (Weapon, Armor, Sorcery…)
    final String type = args['type']; //Tipo de objeto ("weapon", "armor", "sorcery"…)

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //AppBar con imagen grande y título
          _CustomAppBar(item: item, type: type),

          //Contenido debajo del AppBar
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(item: item, type: type), //Imagen pequeña + nombre + categoría
              const SizedBox(height: 20),
              _ItemDescription(item: item), //Descripción del objeto
              const SizedBox(height: 20),
              _ItemStats(item: item, type: type), //Estadísticas específicas según tipo
              const SizedBox(height: 30),
            ]),
          ),
        ],
      ),
    );
  }
}

//AppBar expandible con la imagen de fondo y el nombre del objeto
class _CustomAppBar extends StatelessWidget {
  final dynamic item;
  final String type;
  const _CustomAppBar({required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = item.image ?? '';
    final String title = item.name ?? 'Sin nombre';

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black54,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        background: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.amber)),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
              )
            : Image.asset('assets/no-image.jpg', fit: BoxFit.cover),
      ),
    );
  }
}

//Sección con la imagen pequeña (con Hero), nombre y categoría/peso
class _PosterAndTitle extends StatelessWidget {
  final dynamic item;
  final String type;
  const _PosterAndTitle({required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String imageUrl = item.image ?? '';

    String subtitle = '';
    if (type == 'weapon') subtitle = item.category ?? '';
    if (type == 'armor') subtitle = item.category ?? '';
    if (type == 'sorcery') subtitle = 'Hechizo';

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: item.id ?? UniqueKey(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 130,
                height: 190,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'Sin nombre',
                  style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: textTheme.titleMedium?.copyWith(color: Colors.amber[700]),
                ),
                const SizedBox(height: 10),
                if (type == 'weapon' || type == 'shield')
                  Row(
                    children: [
                      const Icon(Icons.scale, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text('Peso: ${item.weight}', style: textTheme.bodyMedium),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Sección de la descripción/lore del objeto
class _ItemDescription extends StatelessWidget {
  final dynamic item;
  const _ItemDescription({required this.item});

  @override
  Widget build(BuildContext context) {
    final String desc = item.description ?? 'Sin descripción disponible.';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Descripción', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 10),
          Text(
            desc,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

//Sección de estadísticas, cambia según el tipo de objeto
class _ItemStats extends StatelessWidget {
  final dynamic item;
  final String type;
  const _ItemStats({required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Estadísticas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 10),

          //ARMAS Y ESCUDOS
          if (type == 'weapon') ...[
            _buildAttackRow(item.attack),
            _buildDefenseRow(item.defence ?? []),
            _buildScalingRow(item.scalesWith ?? []),
            _buildRequirementsRow(item.requiredAttributes ?? []),
          ]

          //ARMADURAS
          else if (type == 'armor') ...[
            _buildDamageNegation(item.dmgNegation),
            _buildResistances(item.resistance),
            Text('Peso: ${item.weight}', style: const TextStyle(fontSize: 16)),
          ]

          //HECHIZOS
          else if (type == 'sorcery' ) ...[
            Text('Costo FP: ${item.cost}', style: const TextStyle(fontSize: 16)),
            Text('Slots: ${item.slots}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            _buildRequirementsRow(item.requires),
          ]

          //ESPÍRITUS
          else if (type == 'spirit') ...[
            Text('Costo FP: ${item.fpCost}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyan)),
            Text('Costo HP: ${item.hpCost}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text(item.effect ?? '', style: const TextStyle(fontStyle: FontStyle.italic)),
          ]

          //TALISMANES
          else if (type == 'talisman') ...[
            Text(
              item.effect ?? 'Sin efecto especificado',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.green),
            ),
          ],
        ],
      ),
    );
  }

  //Filas auxiliares para mostrar estadísticas
  Widget _buildAttackRow(List<dynamic> attack) => _StatsRow(title: "Daño", stats: attack);
  Widget _buildDefenseRow(List<dynamic> defence) => _StatsRow(title: "Defensa", stats: defence);
  Widget _buildDamageNegation(List<dynamic> dmgNegation) => _StatsRow(title: "Negación de daño", stats: dmgNegation);
  Widget _buildResistances(List<dynamic> resistance) => _StatsRow(title: "Resistencias", stats: resistance);

  Widget _buildScalingRow(List<dynamic> scalesWith) {
    if (scalesWith.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Escalado:", style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 10,
          children: scalesWith.map<Widget>((s) => Chip(
            label: Text("${s.name}: ${s.scaling}"),
            backgroundColor: Colors.amber[800],
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildRequirementsRow(List<dynamic> requires) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Requisitos:", style: TextStyle(fontWeight: FontWeight.bold)),
        ...requires.map((req) => Text("  • ${req.name}: ${req.amount}")),
      ],
    );
  }
}

//Widget reutilizable para mostrar una fila de estadísticas en fila (Daño, Defensa…)
class _StatsRow extends StatelessWidget {
  final String title;
  final List<dynamic> stats;
  const _StatsRow({required this.title, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title:", style: const TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 15,
          children: stats.map<Widget>((stat) {
            final color = stat.amount > 0 ? Colors.white : Colors.grey;
            return Text("${stat.name}: ${stat.amount}", style: TextStyle(color: color));
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}